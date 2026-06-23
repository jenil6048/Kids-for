import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// THIS IS A UTILITY TOOL TO BULK UPLOAD ASSETS TO SUPABASE STORAGE
/// 1. Add your images to a folder in assets (e.g., assets/images/new_category/)
/// 2. Ensure they are declared in pubspec.yaml (either individually or by folder)
/// 3. Run this file/screen
/// 4. Enter the path and bucket name, then click Upload.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Using Service Role Key for Admin Uploads (Bypasses RLS)
  await Supabase.initialize(
    url: 'https://pdhqylmzjdkvdbnezwhq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkaHF5bG16amRrdmRibmV6d2hxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4MTkwMTcyMiwiZXhwIjoyMDk3NDc3NzIyfQ.78UUcBoIg5t-crhL9aHge99BFw7Z4fXACLGtTijcMiI',
  );

  runApp(const MaterialApp(
    home: AssetUploaderScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AssetUploaderScreen extends StatefulWidget {
  const AssetUploaderScreen({super.key});

  @override
  State<AssetUploaderScreen> createState() => _AssetUploaderScreenState();
}

class _AssetUploaderScreenState extends State<AssetUploaderScreen> {
  final TextEditingController _folderController = TextEditingController(text: 'assets/images/test/');
  final TextEditingController _bucketController = TextEditingController(text: 'assets');
  final TextEditingController _targetPathController = TextEditingController(text: 'test/');
  final TextEditingController _manualListController = TextEditingController();
  int _quality = 80;
  
  bool _isUploading = false;
  String _status = 'Ready';
  double _progress = 0;
  final List<String> _logs = [];

  void _addLog(String message) {
    if (!mounted) return;
    setState(() {
      _logs.insert(0, "${DateTime.now().toLocal().toString().split(' ')[1].split('.')[0]} - $message");
    });
    debugPrint(message);
  }

  Future<void> _startUpload() async {
    final folderPath = _folderController.text.trim();
    final bucketName = _bucketController.text.trim();
    var targetPath = _targetPathController.text.trim();

    if (folderPath.isEmpty || bucketName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter folder path and bucket name')),
      );
      return;
    }

    if (targetPath.isNotEmpty && !targetPath.endsWith('/')) {
      targetPath += '/';
    }

    setState(() {
      _isUploading = true;
      _status = 'Fetching assets...';
      _progress = 0;
      _logs.clear();
    });

    try {
      List<String> assetsToUpload = [];
      final manualList = _manualListController.text.trim();

      if (manualList.isNotEmpty) {
        _addLog("Using manual asset list...");
        assetsToUpload = manualList
            .split(RegExp(r'[\n,]'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      } else {
        // 1. Load Asset Manifest using the modern Flutter API
        _addLog("Loading Asset Manifest...");
        try {
          final AssetManifest manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
          assetsToUpload = manifest.listAssets()
              .where((path) => path.startsWith(folderPath))
              .toList();
        } catch (e) {
          _addLog("Modern AssetManifest failed, trying legacy JSON...");
          try {
            String manifestContent = await rootBundle.loadString('AssetManifest.json');
            final Map<String, dynamic> manifestMap = json.decode(manifestContent);
            assetsToUpload = manifestMap.keys
                .where((path) => path.startsWith(folderPath))
                .toList();
          } catch (e2) {
            _addLog("Legacy AssetManifest also failed: $e2");
            _addLog("Please ensure you have run 'flutter pub get' and the folder is in pubspec.yaml");
            throw "Could not load any Asset Manifest";
          }
        }
      }

      if (assetsToUpload.isEmpty) {
        _addLog("No assets found starting with: $folderPath");
        _addLog("Make sure the folder is added to pubspec.yaml");
        setState(() {
          _isUploading = false;
          _status = 'No assets found';
        });
        return;
      }

      _addLog("Found ${assetsToUpload.length} assets to upload.");

      // 3. Upload each asset to Supabase Storage
      final supabase = Supabase.instance.client;
      int count = 0;

      for (final assetPath in assetsToUpload) {
        try {
          _addLog("Processing: $assetPath");
          
          // Load bytes from asset bundle
          final ByteData data = await rootBundle.load(assetPath);
          Uint8List bytes = data.buffer.asUint8List();
          
          final String fileName = assetPath.split('/').last;
          final String storagePath = '$targetPath$fileName'; 

          // Determine content type based on extension
          String contentType = 'image/png';
          bool canCompress = false;
          CompressFormat format = CompressFormat.png;

          if (assetPath.endsWith('.jpg') || assetPath.endsWith('.jpeg')) {
            contentType = 'image/jpeg';
            canCompress = true;
            format = CompressFormat.jpeg;
          } else if (assetPath.endsWith('.png')) {
            contentType = 'image/png';
            canCompress = true;
            format = CompressFormat.png;
          } else if (assetPath.endsWith('.svg')) {
            contentType = 'image/svg+xml';
          } else if (assetPath.endsWith('.json')) {
            contentType = 'application/json';
          }

          // 4. Compress if it's an image
          if (canCompress && _quality < 100) {
            _addLog("Compressing image (Quality: $_quality%)...");
            final originalSize = bytes.length;
            final compressedBytes = await FlutterImageCompress.compressWithList(
              bytes,
              quality: _quality,
              format: format,
            );
            
            final reduction = ((originalSize - compressedBytes.length) / originalSize * 100).toStringAsFixed(1);
            _addLog("Compressed: ${(originalSize / 1024).toStringAsFixed(1)}KB -> ${(compressedBytes.length / 1024).toStringAsFixed(1)}KB (-$reduction%)");
            bytes = compressedBytes;
          }

          _addLog("Uploading to bucket '$bucketName'...");
          
          await supabase.storage.from(bucketName).uploadBinary(
            storagePath,
            bytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: contentType,
            ),
          );

          count++;
          setState(() {
            _progress = count / assetsToUpload.length;
            _status = 'Uploading ($count/${assetsToUpload.length})';
          });
          _addLog("✅ Success: $assetPath");
        } catch (e) {
          _addLog("❌ Failed: $assetPath - Error: $e");
        }
      }

      setState(() {
        _status = 'Finished! Uploaded $count files.';
        _progress = 1.0;
      });
      _addLog("Upload process completed successfully.");

    } catch (e) {
      _addLog("💥 Critical Error: $e");
      setState(() {
        _status = 'Error occurred';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Asset Uploader'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        color: const Color(0xFFF8F9FE),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.amber.shade50,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This tool uploads assets from your local "assets" folder to Supabase Storage. Ensure files are listed in pubspec.yaml.',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _folderController,
              decoration: InputDecoration(
                labelText: 'Asset Folder Path',
                hintText: 'e.g. assets/images/categories/',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.folder_open),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bucketController,
              decoration: InputDecoration(
                labelText: 'Supabase Bucket Name',
                hintText: 'e.g. assets',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.storage_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _targetPathController,
              decoration: InputDecoration(
                labelText: 'Target Path in Bucket',
                hintText: 'e.g. categories/',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.account_tree_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _manualListController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Specific Asset List (Optional)',
                hintText: 'Paste paths here, separated by comma or newline\ne.g. assets/images/a.png, assets/images/b.png',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.list_alt_rounded),
                helperText: 'Leave empty to upload entire folder above',
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Compression Quality', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('$_quality%', style: const TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _quality.toDouble(),
                    min: 10,
                    max: 100,
                    divisions: 18,
                    activeColor: const Color(0xFF2E7D32),
                    onChanged: (val) => setState(() => _quality = val.toInt()),
                  ),
                  const Text('Lower quality = smaller file size. Set to 100 to disable.', style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isUploading ? null : _startUpload,
                icon: _isUploading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.cloud_upload_rounded),
                label: Text(
                  _isUploading ? 'UPLOADING...' : 'START BULK UPLOAD',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _status,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                ),
                Text("${(_progress * 100).toInt()}%"),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                color: const Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Activity Logs:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _logs.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      _logs[index],
                      style: const TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
