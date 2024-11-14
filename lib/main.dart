import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_trackpi/controller/task_controller.dart';
import 'package:todo_app_trackpi/utils/colorsconstants/colorconstants.dart';
import 'package:todo_app_trackpi/view/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TaskController.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // ------ scaffold background color -----------
          scaffoldBackgroundColor: Colorconstants.backgroundColor,
          // ------ appbar background color -----------
          appBarTheme: const AppBarTheme(
              backgroundColor: Colorconstants.backgroundColor,
              iconTheme: IconThemeData(
                color: Colorconstants.whiteColor,
              )),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
