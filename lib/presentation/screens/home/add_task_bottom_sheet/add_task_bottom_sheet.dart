import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static void show(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * .4,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          'Add New Task',
          textAlign: TextAlign.center,
          style: LightAppStyle.bottomSheetTitle,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your task title',
            hintStyle: LightAppStyle.textFieldHint,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your task details',
            hintStyle: LightAppStyle.textFieldHint,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Select date',
          style: LightAppStyle.date,
        ),
        InkWell(
          onTap: () {
            showTaskDate(context);
          },
          child: Text(
            // formattedDate(selectedDate),
            selectedDate.toFormattedDate,
            style: LightAppStyle.textFieldHint,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Add Task'),
        ),
      ]),
    );
  }

  Future<void> showTaskDate(context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}
