import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_trackpi/controller/task_controller.dart';
import 'package:todo_app_trackpi/utils/colorsconstants/colorconstants.dart';

class TaskUnCompleted extends StatefulWidget {
  const TaskUnCompleted({super.key});

  @override
  State<TaskUnCompleted> createState() => _TaskUnCompletedState();
}

class _TaskUnCompletedState extends State<TaskUnCompleted> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<TaskController>().getAllUnCompletedTodoList();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colorconstants.taskBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.separated(
                itemBuilder: (context, index) => Row(
                  children: [
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      TaskController.unCompletedTodoList[index]['title'],
                      style: const TextStyle(
                          color: Colorconstants.whiteColor, fontSize: 20),
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: TaskController.unCompletedTodoList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
