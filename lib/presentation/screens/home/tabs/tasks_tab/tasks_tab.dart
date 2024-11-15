import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_styles.dart';
import 'package:todo_app/core/utils/colors_manager.dart';
import 'package:todo_app/core/utils/date_ex/date_ex.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/task_item/task_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();
  List<ToDoDM> tasksList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasksFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ColorsManager.blue,
          height: 60.h,
        ),
        Column(
          children: [
            buildDateTimeLine(),
            Expanded(
                child: ListView.builder(
              itemCount: tasksList.length,
              itemBuilder: (context, index) => TaskItem(
                  todo: tasksList[index],
                  onDelete: () {
                    getTasksFromFireStore();
                  }),
            )),
          ],
        ),
      ],
    );
  }

  Widget buildDateTimeLine() {
    return EasyInfiniteDateTimeLine(
      headerBuilder: (context, date) => Container(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      focusDate: selectedDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      itemBuilder:
          (context, dayNumber, dayName, monthName, fullDate, isSelected) =>
              InkWell(
        onTap: () {
          selectedDate = fullDate;
          getTasksFromFireStore();
        },
        child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.r))),
            color: ColorsManager.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fullDate.getDaysName,
                  style: isSelected
                      ? LightAppStyle.selectedDate
                      : LightAppStyle.unselectedDate,
                ),
                SizedBox(
                  height: 14.h,
                ),
                Text(
                  '${fullDate.day}',
                  style: isSelected
                      ? LightAppStyle.selectedDate
                      : LightAppStyle.unselectedDate,
                ),
              ],
            )),
      ),
    );
  }

  void getTasksFromFireStore() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(ToDoDM.collectionName);
    QuerySnapshot collectionSnapShot = await collectionReference
        .where('dateTime',
            isEqualTo: selectedDate.copyWith(
              hour: 0,
              minute: 0,
              second: 0,
              millisecond: 0,
              microsecond: 0,
            ))
        .get();
    List<QueryDocumentSnapshot> documentsSnapShot = collectionSnapShot.docs;
    tasksList = documentsSnapShot.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
      ToDoDM todo = ToDoDM.fromFireStore(json);
      return todo;
    }).toList();
    // tasksList = tasksList
    //     .where((task) =>
    //         task.dateTime.day == selectedDate.day &&
    //         task.dateTime.month == selectedDate.month &&
    //         task.dateTime.year == selectedDate.year)
    //     .toList();
    setState(() {});
  }
}
