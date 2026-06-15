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
}
