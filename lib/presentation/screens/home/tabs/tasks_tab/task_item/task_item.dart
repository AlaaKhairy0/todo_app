import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: ColorsManager.white,
      ),
      child: Slidable(
        startActionPane: ActionPane(
            extentRatio: .4,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                icon: Icons.delete,
                label: 'Delete',
                backgroundColor: ColorsManager.red,
                onPressed: (context) {},
              ),
              SlidableAction(
                icon: Icons.edit,
                label: 'Edit',
                backgroundColor: ColorsManager.blue,
                onPressed: (context) {},
              )
            ]),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: const BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Task title',
                    style: LightAppStyle.taskItemTitle,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Task description',
                    style: LightAppStyle.taskItemDescription,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
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
}
