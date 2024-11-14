import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_trackpi/controller/task_controller.dart';
import 'package:todo_app_trackpi/utils/colorsconstants/colorconstants.dart';

class TaskPageView extends StatelessWidget {
  int? todoLength;
  TaskPageView({
    super.key,
    this.todoLength,
  });

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<TaskController>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: List.generate(
          //       3,
          //       (currentCategoryIndex) => Padding(
          //         padding: const EdgeInsets.only(right: 15.0),
          //         child: InkWell(
          //           onTap: () {
          //             providerObj.todoCategories(currentCategoryIndex);
          //           },
          //           child: Container(
          //             height: 35,
          //             width: currentCategoryIndex == 0 ? 60 : 120,
          //             decoration: BoxDecoration(
          //               color: Colorconstants.whiteColor.withOpacity(0.2),
          //               borderRadius: BorderRadius.circular(16),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 currentCategoryIndex == 0
          //                     ? "All"
          //                     : currentCategoryIndex == 1
          //                         ? "Uncompleted"
          //                         : "Completed",
          //                 style: TextStyle(
          //                   color: currentCategoryIndex ==
          //                           providerObj.categoryIndex
          //                       ? Colorconstants.addTaskButton
          //                       : Colorconstants.whiteColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            // ------------- main task container ---------------------------------
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colorconstants.taskBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My tasks',
                        style: TextStyle(
                          color: Colorconstants.whiteColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      // -------------- sort and more icons -------------------------
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // ----------- sort function ------------
                              providerObj.sortFunction();
                            },
                            icon: const Icon(
                              Icons.swap_vert,
                              size: 30,
                              color: Colorconstants.whiteColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // ----------- mark done or delete --------------
                              showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(100, 100, 0, 0),
                                items: [
                                  const PopupMenuItem<int>(
                                    value: 1,
                                    child: Text('Mark as done'),
                                  ),
                                  const PopupMenuItem<int>(
                                    value: 2,
                                    child: Text('Delete'),
                                  ),
                                ],
                                elevation: 8.0,
                              );
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              size: 30,
                              color: Colorconstants.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      // -------------- sort and more icons -------------------------
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // ----------------- List of Task to do ------------------------
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                         todoLength!,
                          (todoListIndex) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // ----------------  task completed or not -----------------
                                  IconButton(
                                    onPressed: () {
                                      providerObj.toggleSelection(TaskController
                                          .todoList[todoListIndex]['id']);
                                    },
                                    icon: providerObj.selectedIndices.contains(
                                            TaskController
                                                .todoList[todoListIndex]['id'])
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Colorconstants.addTaskButton,
                                          )
                                        : const Icon(
                                            Icons.circle_outlined,
                                            color: Colorconstants.whiteColor,
                                          ),
                                  ),
                                  // ----------------  task completed or not -----------------
                                  // ----------------  task Name --------------------------
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TaskController.todoList[todoListIndex]
                                              ['title'],
                                          style: const TextStyle(
                                            color: Colorconstants.whiteColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          TaskController.todoList[todoListIndex]
                                              ['description'],
                                          style: TextStyle(
                                            color: Colorconstants.whiteColor
                                                .withOpacity(0.5),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ----------------  task Name --------------------------

                                  // ----------------  star Button  --------------------------
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.priority_high,
                                      color:
                                          TaskController.todoList[todoListIndex]
                                                      ['priority'] ==
                                                  0
                                              ? Colors.red
                                              : TaskController.todoList[
                                                              todoListIndex]
                                                          ['priority'] ==
                                                      1
                                                  ? Colors.orange
                                                  : Colorconstants.whiteColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      providerObj.removeDb(TaskController
                                          .todoList[todoListIndex]['id']);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colorconstants.whiteColor,
                                    ),
                                  ),

                                  // ----------------  star Button  --------------------------
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // ----------------- List of Task to do ------------------------
                ],
              ),
            ),

            // ------------- main task container ---------------------------------
          )
        ],
      ),
    );
  }
}
