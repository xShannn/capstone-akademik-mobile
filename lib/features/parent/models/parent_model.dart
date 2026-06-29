import 'child_model.dart';

class ParentModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<ChildModel> children;

  const ParentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.children,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    final parent = json['parent'] ?? json['user'] ?? json;
    final childrenData = parent['children'] ?? json['children'] ?? [];

    return ParentModel(
      id: parent['id']?.toString() ?? parent['parent_id']?.toString() ?? '',
      name: parent['name']?.toString() ?? '',
      email: parent['email']?.toString() ?? '',
      phone:
          parent['phone']?.toString() ??
          parent['phone_number']?.toString() ??
          '',
      children: childrenData is List
          ? childrenData
                .map(
                  (item) => ChildModel.fromJson(
                    Map<String, dynamic>.from(item as Map),
                  ),
                )
                .toList()
          : [],
    );
  }
}
