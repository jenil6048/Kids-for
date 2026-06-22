import 'localized_text.dart';

class TopicModel {
  final int id;
  final String topicKey;
  final int categoryId;
  final LocalizedText name;
  final String? svgPath;
  final String? imagePath;
  final String? lottiePath;
  final LocalizedText narration;
  final LocalizedText explanation;
  final LocalizedText fact;
  final String gameType;
  final bool isFree;
  final int displayOrder;

  TopicModel({
    required this.id,
    required this.topicKey,
    required this.categoryId,
    required this.name,
    this.svgPath,
    this.imagePath,
    this.lottiePath,
    required this.narration,
    required this.explanation,
    required this.fact,
    required this.gameType,
    required this.isFree,
    required this.displayOrder,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'] as int,
      topicKey: json['topic_key'] as String? ?? '',
      categoryId: json['category_id'] as int? ?? 0,
      name: json['name'] is Map
          ? LocalizedText.fromJson(Map<String, dynamic>.from(json['name'] as Map))
          : LocalizedText(en: json['name']?.toString() ?? '', gu: '', hi: ''),
      svgPath: json['svg_path'] as String?,
      imagePath: json['image_path'] as String?,
      lottiePath: json['lottie_path'] as String?,
      narration: json['narration'] is Map
          ? LocalizedText.fromJson(Map<String, dynamic>.from(json['narration'] as Map))
          : LocalizedText(en: json['narration']?.toString() ?? '', gu: '', hi: ''),
      explanation: json['explanation'] is Map
          ? LocalizedText.fromJson(Map<String, dynamic>.from(json['explanation'] as Map))
          : LocalizedText(en: json['explanation']?.toString() ?? '', gu: '', hi: ''),
      fact: json['fact'] is Map
          ? LocalizedText.fromJson(Map<String, dynamic>.from(json['fact'] as Map))
          : LocalizedText(en: json['fact']?.toString() ?? '', gu: '', hi: ''),
      gameType: json['game_type'] as String? ?? 'memory',
      isFree: json['is_free'] as bool? ?? true,
      displayOrder: json['display_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic_key': topicKey,
      'category_id': categoryId,
      'name': name.toJson(),
      'svg_path': svgPath,
      'image_path': imagePath,
      'lottie_path': lottiePath,
      'narration': narration.toJson(),
      'explanation': explanation.toJson(),
      'fact': fact.toJson(),
      'game_type': gameType,
      'is_free': isFree,
      'display_order': displayOrder,
    };
  }

  String getName({String locale = 'en'}) => name.get(locale);
  String getNarration({String locale = 'en'}) => narration.get(locale);
  String getExplanation({String locale = 'en'}) => explanation.get(locale);
  String getFact({String locale = 'en'}) => fact.get(locale);
}
