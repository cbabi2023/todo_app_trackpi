import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TaskController with ChangeNotifier {
  // ------------ todo list Categories -------------------------
  int? categoryIndex; // to store selected category Index
  todoCategories(int currentCategoryIndex) {
    categoryIndex = currentCategoryIndex;
    notifyListeners();
  }

  //----------------  Database -------------------------------------------

  late Database database;
  List todoList = [];

  // ------------ initializing Database ----------------------------------

  Future initDb() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE TodoTable (id INTEGER PRIMARY KEY, title TEXT, description TEXT, priority INTEGER)');
    });
  }

  // ------------ Get All Todo List from Database ----------------------------------
  getAllTodoList() async {
    todoList = await database.rawQuery('SELECT * FROM TodoTable');
  }

  // ------------ Adding Todo  to Database ----------------------------------
  addTodo(String todoTitle, String todoDescription, int priority) async {
    await database.rawInsert(
        'INSERT INTO TodoTable(title, description, priority) VALUES(?, ?, ?)',
        [todoTitle, todoDescription, priority]);
  }

  // ---------------------- Update database ------------------------------------
  updateDb(String todoTitle, String todoDescription, int priority) async {
    await database.rawUpdate(
        'UPDATE TodoTable SET title = ?, description = ?,priority = ? WHERE id = ?',
        [todoTitle, todoDescription, priority]);
  }

// ------------------ remove data from database --------------------------------
  removeDb(int productId) async {
    await database.rawDelete('DELETE FROM TodoTable WHERE id = ?', [productId]);
  }

  //----------------  Database -------------------------------------------
}
