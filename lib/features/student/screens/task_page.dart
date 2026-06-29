import 'package:flutter/material.dart';
import 'package:mobile_sekolah/features/student/models/student_task_model.dart';
import 'package:mobile_sekolah/features/student/widgets/empty_state_widget.dart';
import 'package:mobile_sekolah/features/student/widgets/task_card.dart';

class TaskPage extends StatefulWidget {
  final Function(int)? onTabChange;
  final List<StudentTaskModel> tasks;
  final Function(StudentTaskModel) onToggleTask;

  const TaskPage({
    super.key,
    this.onTabChange,
    required this.tasks,
    required this.onToggleTask,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _activeFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredTasks = widget.tasks.where((task) {
      if (_activeFilter == 'Pending') return !task.isDone;
      if (_activeFilter == 'Done') return task.isDone;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F42B3),
        elevation: 0,
        // leading dihapus
        title: const Text('Tasks', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildFilter(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredTasks.isEmpty
                ? const EmptyStateWidget(message: 'Belum ada tugas')
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskCard(
                        title: task.title,
                        teacher: task.teacher,
                        deadline: task.deadline,
                        description: task.description,
                        isDone: task.isDone,
                        onToggle: () => widget.onToggleTask(task),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: ['All', 'Pending', 'Done'].map((item) {
          final active = _activeFilter == item;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _activeFilter = item;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF0F42B3) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: active ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
