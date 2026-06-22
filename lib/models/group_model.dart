import 'localized_text.dart';

class GroupModel {
  final String id;
  final LocalizedText name;
  final String icon;

  GroupModel({
    required this.id,
    required this.name,
    required this.icon,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.toJson(),
      'icon': icon,
    };
  }

  String getName({String locale = 'en'}) {
    return name.get(locale);
  }
}
