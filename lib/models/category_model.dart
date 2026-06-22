import 'group_model.dart';
import 'localized_text.dart';

class CategoryModel {
  final int id;
  final String categoryKey;
  final LocalizedText title;
  final String color;
  final bool isPremium;
  final String groupId;
  final String? imagePath;
  final String? lottiePath;
  final int displayOrder;
  final GroupModel? group;

  CategoryModel({
    required this.id,
    required this.categoryKey,
    required this.title,
    required this.color,
    required this.isPremium,
    required this.groupId,
    this.imagePath,
    this.lottiePath,
    required this.displayOrder,
    this.group,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      categoryKey: json['category_key'] as String? ?? '',
      title: json['title'] is Map
          ? LocalizedText.fromJson(Map<String, dynamic>.from(json['title'] as Map))
          : LocalizedText(
              en: json['title']?.toString() ?? '',
              gu: '',
              hi: '',
            ),
      color: json['color'] as String? ?? '#FF9800',
      isPremium: json['is_premium'] as bool? ?? false,
      groupId: json['group_id'] as String? ?? '',
      imagePath: json['image_path'] as String?,
      lottiePath: json['lottie_path'] as String?,
      displayOrder: json['display_order'] as int? ?? 0,
      group: json['groups'] != null
          ? GroupModel.fromJson(json['groups'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_key': categoryKey,
      'title': title.toJson(),
      'color': color,
      'is_premium': isPremium,
      'group_id': groupId,
      'image_path': imagePath,
      'lottie_path': lottiePath,
      'display_order': displayOrder,
      if (group != null) 'groups': group!.toJson(),
    };
  }

  String getTitle({String locale = 'en'}) {
    return title.get(locale);
  }
}
