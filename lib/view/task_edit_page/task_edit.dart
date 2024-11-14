import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_trackpi/controller/task_controller.dart';
import 'package:todo_app_trackpi/utils/colorsconstants/colorconstants.dart';
import 'package:todo_app_trackpi/view/home_screen/home_screen.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        TaskController.initDb();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<TaskController>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          // -------------- star and more icons -------------------------
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star,
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
          // -------------- star and more icons -------------------------
        ],
      ),

      // body
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // -------------- Title  Text --------------------------------------
            CustomTextfiled(
              hinText: "Enter  Title",
              controller: titleController,
              boxheight: 60,
              maxlength: 40,
              maxlines: 1,
            ),
            // -------------- Title  Text --------------------------------------

            const SizedBox(
              height: 20,
            ),

            // -------------- description  Text --------------------------------------
            CustomTextfiled(
              hinText: "Enter Details",
              controller: descriptionController,
              boxheight: 150,
              maxlength: 150,
              maxlines: 5,
              toppadding: 0,
              userTypefontSize: 18,
            ),
            // -------------- description  Text --------------------------------------

            const SizedBox(
              height: 20,
            ),

            const Text(
              'Your Priority',
              style: TextStyle(
                color: Colorconstants.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // priority Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (priorityIndex) => Row(
                  children: [
                    Radio(
                      activeColor: Colorconstants.addTaskButton,
                      value: priorityIndex,
                      groupValue: providerObj.priorityIndex,
                      onChanged: (priorityValue) {
                        providerObj.todoPriorities(priorityValue!);
                      },
                    ),
                    Text(
                      priorityIndex == 0
                          ? "High"
                          : priorityIndex == 1
                              ? "Medium"
                              : "Low",
                      style: const TextStyle(
                        color: Colorconstants.whiteColor,
                      ),
                    ),
                    priorityIndex == 2
                        ? const SizedBox(
                            width: 10,
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // ------------- Save Button -----------------------------------
            InkWell(
              onTap: () async {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    providerObj.priorityIndex != null) {
                  // details saved to the database
                  await providerObj.addTodoDb(
                      todoTitle: titleController.text,
                      todoDescription: descriptionController.text,
                      priority: providerObj.priorityIndex!);

                  // database upto date and loged in the console
                  await providerObj.getAllTodoList();

                  // Navigate to home screen
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please fill the Details'),
                    ),
                  );
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colorconstants.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text('Save'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ------------- Save Button -----------------------------------
          ],
        ),
      ),
    );
  }
}

class CustomTextfiled extends StatelessWidget {
  double? boxheight;
  int? maxlines;
  int? maxlength;
  double? toppadding;
  double? userTypefontSize;
  String? hinText;
  TextEditingController? controller;

  CustomTextfiled({
    super.key,
    this.boxheight,
    this.maxlength,
    this.maxlines,
    this.toppadding,
    this.userTypefontSize,
    this.hinText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxheight,
      padding: EdgeInsets.only(top: toppadding ?? 20, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colorconstants.whiteColor.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxlines,
        maxLength: maxlength,
        style: TextStyle(
          color: Colorconstants.whiteColor,
          fontSize: userTypefontSize ?? 20,
        ),
        decoration: InputDecoration(
          counterStyle: const TextStyle(
            color: Colorconstants.whiteColor,
          ),
          border: InputBorder.none,
          hintText: hinText,
          hintStyle: TextStyle(
            color: Colorconstants.whiteColor.withOpacity(0.5),
            fontSize: 20,
          ),
          contentPadding: const EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
        ),
      ),
    );
  }
}
