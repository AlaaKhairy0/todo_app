import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddTaskBottomSheet(),
      ),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * .4,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'Add New Task',
            textAlign: TextAlign.center,
            style: LightAppStyle.bottomSheetTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return 'Enter task title';
            },
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Enter your task title',
              hintStyle: LightAppStyle.textFieldHint,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return 'Enter task description';
            },
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Enter your task description',
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
            onPressed: () {
              addTaskToFireStore();
            },
            child: const Text('Add Task'),
          ),
        ]),
      ),
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

  void addTaskToFireStore() {
    if (formKey.currentState!.validate() == false) return;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(ToDoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc();
    ToDoDM task = ToDoDM(
        id: documentReference.id,
        title: titleController.text,
        description: descriptionController.text,
        isDone: false,
        dateTime: selectedDate.copyWith(
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        ));
    documentReference.set(task.toFireStore()).timeout(
      const Duration(milliseconds: 500),
      onTimeout: () {
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}