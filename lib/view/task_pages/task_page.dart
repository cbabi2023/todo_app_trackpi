import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_trackpi/controller/task_controller.dart';
import 'package:todo_app_trackpi/utils/colorsconstants/colorconstants.dart';

class TaskPageView extends StatelessWidget {
  const TaskPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<TaskController>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                4,
                (currentCategoryIndex) => Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                    onTap: () {
                      providerObj.todoCategories(currentCategoryIndex);
                    },
                    child: Container(
                      height: 35,
                      width: currentCategoryIndex == 0 ? 60 : 120,
                      decoration: BoxDecoration(
                        color: Colorconstants.whiteColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          currentCategoryIndex == 0
                              ? "All"
                              : currentCategoryIndex == 1
                                  ? "Starred"
                                  : currentCategoryIndex == 2
                                      ? "Completed"
                                      : "Uncompleted",
                          style: TextStyle(
                            color: currentCategoryIndex ==
                                    providerObj.categoryIndex
                                ? Colorconstants.addTaskButton
                                : Colorconstants.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.swap_vert,
                              size: 30,
                              color: Colorconstants.whiteColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
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
                          20,
                          (index) => Row(
                            children: [
                              // ----------------  task completed or not -----------------
                              Radio(
                                value: 0,
                                groupValue: true,
                                onChanged: (value) {},
                              ),
                              // ----------------  task completed or not -----------------
                              // ----------------  task Name --------------------------
                              const Expanded(
                                child: Text(
                                  "Priority",
                                  style: TextStyle(
                                    color: Colorconstants.whiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                              // ----------------  task Name --------------------------

                              // ----------------  star Button  --------------------------
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.star,
                                  color: Colorconstants.whiteColor,
                                ),
                              ),

                              // ----------------  star Button  --------------------------
                            ],
                          ),
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
