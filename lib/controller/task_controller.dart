import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TaskController with ChangeNotifier {
  // ------------ todo list Categories -------------------------
  int? categoryIndex; // to store selected category Index
  todoCategories(int currentCategoryIndex) {
    categoryIndex = currentCategoryIndex;
    if (categoryIndex == 0) {
      getAllCompletedTodoList();
    } else {
      getAllTodoList();
    }
    notifyListeners();
    log('$categoryIndex');
  }

  // ------------ todo list Priority -------------------------
  int? priorityIndex;
  todoPriorities(int value) {
    priorityIndex = value;
    notifyListeners();

    log('$priorityIndex');
  }

  // ---------------- todo List Index ---------------------------
  int? todoListIndex;

  todoListview(int listViewIndex) {
    todoListIndex = listViewIndex;

    notifyListeners();
  }

  //----------------  Database -------------------------------------------

  static late Database database;
  static List todoList = [];
  bool isAscending = true;

  // ------------ initializing Database ----------------------------------

  static Future<void> initDb() async {
    database = await openDatabase('todo1.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE TodoTable (id INTEGER PRIMARY KEY, title TEXT, description TEXT, priority INTEGER, iscompleted INTEGER )');
    });
  }

  // ------------ Get All Todo List from Database ----------------------------------

  getAllTodoList() async {
    String orderBy = isAscending ? "ASC" : "DESC";

    todoList = await database.rawQuery(
        'SELECT * FROM TodoTable ORDER BY priority $orderBy, id $orderBy');

    log("$todoList");
    notifyListeners();
  }

  // ------------ Get Completed Todo List from Database ----------------------------------

  static List completedTodoList = [];
  getAllCompletedTodoList() async {
    String orderBy = isAscending ? "ASC" : "DESC";

    // Retrieve all todo items with iscompleted = 1
    completedTodoList = await database.rawQuery(
        'SELECT * FROM TodoTable WHERE iscompleted = 1 ORDER BY priority $orderBy, id $orderBy');

    log("$todoList");
    notifyListeners();
  }

  // ------------ Get UnCompleted Todo List from Database ----------------------------------

  static List unCompletedTodoList = [];
  getAllUnCompletedTodoList() async {
    String orderBy = isAscending ? "ASC" : "DESC";

    // Retrieve all todo items with iscompleted = 1
    unCompletedTodoList = await database.rawQuery(
        'SELECT * FROM TodoTable WHERE iscompleted = 0 ORDER BY priority $orderBy, id $orderBy');

    log("$todoList");
    notifyListeners();
  }

  // ------------ Adding Todo  to Database ----------------------------------
  addTodoDb(
      {required String todoTitle,
      required String todoDescription,
      required int priority}) async {
    await database.rawInsert(
        'INSERT INTO TodoTable(title, description, priority, iscompleted) VALUES(?, ?, ?,?)',
        [todoTitle, todoDescription, priority, 0]);
    getAllTodoList();
  }

  // ---------------------- Update database ------------------------------------
  updateDb({required int iscompleted, required int todoId}) async {
    await database.rawUpdate(
        'UPDATE TodoTable SET iscompleted = ? WHERE id = ?',
        [iscompleted, todoId]);
    getAllTodoList();
    notifyListeners();
  }

// ------------------ remove data from database --------------------------------
  removeDb(int productId) async {
    await database.rawDelete('DELETE FROM TodoTable WHERE id = ?', [productId]);
    getAllTodoList();
  }

  //----------------  Database -------------------------------------------

  // ----------- sort Function ----------------------------------------------

  sortFunction() {
    isAscending = !isAscending;
    getAllTodoList();
  }

  // first Try to sort Functions

  // List sortedTodoList = todoList;
  // sortTodoList() {
  //   sortedTodoList.sort((a, b) {
  //     int priorityComparison = a['priority'].compareTo(b['priority']);
  //     if (priorityComparison != 0) {
  //       return priorityComparison;
  //     } else {
  //       return a['id'].compareTo(b['id']);
  //     }
  //   });
  //   notifyListeners();
  //   log("$sortedTodoList");
  //   // Assign sorted items to the new list List<Map<String, dynamic>> sortedTodoList = items; print
  // }

  // ----------- Toggle Selection --------------
  Set selectedIndices = {}; // to collect indexes
  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
      updateDb(iscompleted: 0, todoId: index);
    } else {
      selectedIndices.add(index);
      updateDb(iscompleted: 1, todoId: index);
    }
    notifyListeners();
    log("$selectedIndices");
  }
}
