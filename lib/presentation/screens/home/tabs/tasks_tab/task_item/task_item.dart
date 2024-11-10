import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/routes_manager.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/presentation/screens/home/edit_task/edit_task.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, required this.todo, required this.onDelete});

  ToDoDM todo;
  Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.r),
        ),
        color: ColorsManager.white,
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
                  deleteTaskFromFireStore(todo);
                  onDelete();
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
            color: ColorsManager.white,
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
                    style: LightAppStyle.taskItemTitle,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    todo.description,
                    style: LightAppStyle.taskItemDescription,
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
    );
  }

  Future<void> deleteTaskFromFireStore(ToDoDM todo) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(ToDoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc(todo.id);
    await documentReference.delete();
  }
}
