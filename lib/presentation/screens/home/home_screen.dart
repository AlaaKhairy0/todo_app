import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/screens/home/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_app/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_app/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  GlobalKey<TasksTabState> tasksTabState = GlobalKey();

  List<Widget> tabs = [];

  @override
  void initState() {
    tabs = [
      TasksTab(
        key: tasksTabState,
      ),
      const SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[currentIndex],
    );
  }

  Widget buildBottomNavBar() => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        child: BottomAppBar(
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (int index) {
              currentIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                label: AppLocalizations.of(context)!.tasksTab,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings_outlined,
                ),
                label: AppLocalizations.of(context)!.settingsTab,
              ),
            ],
          ),
        ),
      );

  Widget buildFAB() => FloatingActionButton(
        onPressed: () async {
          await AddTaskBottomSheet.show(context);
          tasksTabState.currentState?.getTasksFromFireStore();
        },
        child: const Icon(Icons.add),
      );
}
