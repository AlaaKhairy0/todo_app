import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/dialogs/dialogs.dart';
import 'package:todo_app/core/utils/routes_manager.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home/edit_task/edit_task.dart';

import '../../../../../../providers/theme_provider.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.todo, required this.onDelete});

  ToDoDM todo;
  Function onDelete;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: REdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Slidable(
          startActionPane: ActionPane(
              extentRatio: .4,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                  ),
                  icon: Icons.delete,
                  label: 'Delete',
                  backgroundColor: ColorsManager.red,
                  onPressed: (context) {
                    MyDialog.showMessage(
                      context,
                      body: 'Are you sure you want to delete the task',
                      posActionTitle: 'Yes',
                      negActionTitle: 'Cancel',
                      posAction: () {
                        deleteTaskFromFireStore(context, todo);
                        onDelete();
                      },
                    );
                  },
                ),
                SlidableAction(
                  icon: Icons.edit,
                  label: 'Edit',
                  backgroundColor: ColorsManager.blue,
                  onPressed: (context) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTask(todo: todo),
                        ));
                  },
                )
              ]),
          child: Container(
            padding: REdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 62.h,
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: ColorsManager.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      todo.title,
                      style: themeProvider.isLightMode()
                          ? LightAppStyle.taskItemTitle
                          : DarkAppStyle.taskItemTitle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      todo.description,
                      style: themeProvider.isLightMode()
                          ? LightAppStyle.taskItemDescription
                          : DarkAppStyle.taskItemDescription,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: REdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      color: ColorsManager.blue),
                  child: const Icon(
                    Icons.check,
                    color: ColorsManager.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteTaskFromFireStore(
      BuildContext context, ToDoDM todo) async {
    // if (context.mounted){
    //   MyDialog.showLoading(context,text: 'Waiting...');
    // }
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(ToDoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc(todo.id);
    await documentReference.delete();
    // if(context.mounted){
    //   MyDialog.hide(context);
    //   MyDialog.showMessage(context,posActionTitle: 'Ok',body: 'Task deleted successfully');
    // }
  }
}
