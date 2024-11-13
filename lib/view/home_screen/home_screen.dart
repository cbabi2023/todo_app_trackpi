import 'package:flutter/material.dart';
import 'package:todo_app_trackpi/utils/colorsconstants/colorconstants.dart';
import 'package:todo_app_trackpi/view/task_edit_page/task_edit.dart';
import 'package:todo_app_trackpi/view/task_pages/task_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // --------------- appbar ------------------------------------------------

        appBar: AppBar(
          title: const Text(
            "Todo List",
            style: TextStyle(
              color: Colorconstants.whiteColor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,

          // profile section
          actions: const [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWg7X0YYzUCU5m8BA_sH_ti92q4X0lCz5h_w&s"),
            ),
            SizedBox(
              width: 20,
            )
          ],

          // -------------- bottom TabBar --------------------------------------
        ),
        body: TaskPageView(),

        // ------------- Add a new Task Button -----------------------------------

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colorconstants.addTaskButton,
          focusColor: Colorconstants.whiteColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TaskEditPage(),
              ),
            );
          },
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colorconstants.addTaskIcon,
          ),
        ),
      ),
    );
  }
}
