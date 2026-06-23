import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'custom_text.dart';
import 'custom_loading.dart';

class CustomImage extends StatelessWidget {
  final String pathOrUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomImage({
    super.key,
    required this.pathOrUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.placeholder,
    this.errorWidget,
  });

  String get _cleanPath {
    String path = pathOrUrl.trim();
    // Remove leading slash if present for local assets
    if (path.startsWith('/') && !path.startsWith('//')) {
      path = path.substring(1);
    }
    // Fix common directory mismatch if it occurs in DB paths
    if (path.contains('assets/alphabets/') && !path.contains('assets/svgs/')) {
      path = path.replaceFirst('assets/alphabets/', 'assets/svgs/alphabets/');
    }
    return path;
  }
  bool get _isNetwork => _cleanPath.startsWith('http://') || _cleanPath.startsWith('https://');
  bool get _isSvg => _cleanPath.toLowerCase().contains('.svg');
  bool get _isLottie => _cleanPath.toLowerCase().contains('.json');
  bool get _isEmoji => !_isNetwork && !_cleanPath.contains('/') && !_cleanPath.contains('.');

  @override
  Widget build(BuildContext context) {
    final path = _cleanPath;
    if (path.isEmpty) {
      return _buildErrorWidget();
    }

    if (_isEmoji) {
      return Center(child: CustomText(path, fontSize: (width != null) ? (width! * 0.6).clamp(16.0, 64.0) : 24.0));
    }

    if (_isLottie) {
      return _isNetwork
          ? Lottie.network(
              path,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
            )
          : Lottie.asset(
              path,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
            );
    }

    if (_isSvg) {
      return _isNetwork
          ? SvgPicture.network(
              path,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
              placeholderBuilder: (context) => _buildPlaceholderWidget(),
            )
          : SvgPicture.asset(
              path,
              width: width,
              height: height,
              fit: fit,
              colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
              placeholderBuilder: (context) => _buildPlaceholderWidget(),
              errorBuilder: (context, error, stackTrace) {
                print("error-->$error");
                return _buildErrorWidget();
              },
            );
    }

    // Standard Image (Raster: PNG, JPG, etc.)
    if (_isNetwork) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        placeholder: (context, url) => _buildPlaceholderWidget(),
        errorWidget: (context, url, error) {
          print("error===>$error");
          return _buildErrorWidget();
        },
      );
    } else {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    }
  }

  Widget _buildPlaceholderWidget() {
    return placeholder ??
        CustomLoading(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          borderRadius: 12,
        );
  }

  Widget _buildErrorWidget() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.04), borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Icon(
              _isLottie
                  ? Icons.play_circle_outline_rounded
                  : _isSvg
                  ? Icons.eco_rounded
                  : Icons.image_not_supported_rounded,
              color: Colors.black.withOpacity(0.2),
              size: (width != null) ? (width! * 0.35).clamp(16.0, 48.0) : 24.0,
            ),
          ),
        );
  }
}
