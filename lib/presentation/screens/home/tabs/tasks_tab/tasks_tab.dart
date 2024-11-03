import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/task_item/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TaskItem(),
    );
  }
}