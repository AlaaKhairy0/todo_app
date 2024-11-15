import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/core/utils/dialogs/dialogs.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../providers/theme_provider.dart';

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

  static hide(context) {
    Navigator.pop(context);
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * .4,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            AppLocalizations.of(context)!.addTask,
            textAlign: TextAlign.center,
            style: themeProvider.isLightMode()
                ? LightAppStyle.bottomSheetTitle
                : DarkAppStyle.bottomSheetTitle,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: themeProvider.isLightMode()
                ? LightAppStyle.controller
                : DarkAppStyle.controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return 'Enter task title';
            },
            controller: titleController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.titleHint,
              hintStyle: themeProvider.isLightMode()
                  ? LightAppStyle.textFieldHint
                  : DarkAppStyle.textFieldHint,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            style: themeProvider.isLightMode()
                ? LightAppStyle.controller
                : DarkAppStyle.controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty)
                return 'Enter task description';
            },
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.descriptionHint,
              hintStyle: themeProvider.isLightMode()
                  ? LightAppStyle.textFieldHint
                  : DarkAppStyle.textFieldHint,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            AppLocalizations.of(context)!.selectDate,
            style: themeProvider.isLightMode()
                ? LightAppStyle.date
                : DarkAppStyle.date,
          ),
          InkWell(
            onTap: () {
              showTaskDate(context);
            },
            child: Text(
              // formattedDate(selectedDate),
              selectedDate.toFormattedDate,
              style: themeProvider.isLightMode()
                  ? LightAppStyle.textFieldHint
                  : DarkAppStyle.textFieldHint,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: ColorsManager.blue),
            onPressed: () {
              addTaskToFireStore();
              MyDialog.showLoading(context, text: 'Waiting...');
            },
            child: Text(AppLocalizations.of(context)!.addButton),
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
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(ToDoDM.collectionName);
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
    documentReference.set(task.toFireStore()).then((value) {
      if (context.mounted) {
        MyDialog.hide(context);
        MyDialog.showMessage(
          context,
          body: 'Task added successfully',
          posActionTitle: 'Ok',
          posAction: () => AddTaskBottomSheet.hide(context),
        );
      }
    }).timeout(
      const Duration(seconds: 4),
      onTimeout: () {
        if (mounted) {
          MyDialog.showMessage(
            context,
            title: 'Error',
            body: 'Failed to add the task',
            posActionTitle: 'Ok',
          );
        }

        // if (context.mounted) {
        //   Navigator.pop(context);
        // }
      },
    );
  }
}
