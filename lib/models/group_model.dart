import 'localized_text.dart';

class GroupModel {
  final String id;
  final LocalizedText name;
  final String icon;
  final int displayOrder;

  GroupModel({
    required this.id,
    required this.name,
    required this.icon,
    this.displayOrder = 0,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] as String,
      name: json['name'] is Map
          ? LocalizedText.fromJson(Map<String, dynamic>.from(json['name'] as Map))
          : LocalizedText(
              en: json['name']?.toString() ?? '',
              gu: '',
              hi: '',
            ),
      icon: json['icon'] as String? ?? '',
      displayOrder: json['display_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'icon': icon,
      'display_order': displayOrder,
    };
  }

  String getName({String locale = 'en'}) {
    return name.get(locale);
  }
}
