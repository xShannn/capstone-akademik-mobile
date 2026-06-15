import 'school_stat_model.dart';

class AdminModel {
  final String id;
  final String name;
  final String email;
  final String schoolName;
  final List<SchoolStatModel> stats;

  const AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.schoolName,
    required this.stats,
  });
}
