import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todolist/db/sqlite.dart';
import 'package:todolist/models/todo_models.dart';

class Todo extends ChangeNotifier {
  Todo() {
    _init();
  }

  List<TodoItem> items = [];
  List<TodoCategory> categoryes = [];

  void _init() async {
    await getCategoryes();
  }

  Future getCategoryes() async {
    var _results = await SQLiteProvider.db.select(TodoCategory.table);
    categoryes = _results
        .map<TodoCategory>((item) => TodoCategory.fromMap(item))
        .toList();
    notifyListeners();
  }

  Future addCategory() async {
    await SQLiteProvider.db
        .insert(TodoCategory.table, TodoCategory(title: 'test'));
    log('Category added');
    await getCategoryes();
  }

  Future getItems(int categoryId) async {
    var _results = await SQLiteProvider.db.select(TodoItem.table,
        where: '"category" = ?', whereArgs: [categoryId]);
    items = _results.map<TodoItem>((item) => TodoItem.fromMap(item)).toList();
    notifyListeners();
  }

  Future addItem(TodoItem item) async {
    await SQLiteProvider.db.insert(TodoItem.table, item);
    log('Item add ${item.title}');
    await getItems(item.category);
  }

  Future toggleItem(TodoItem item) async {
    var new_item = TodoItem(
        id: item.id,
        category: item.category,
        title: item.title,
        description: item.description,
        completed: !item.completed);
    await SQLiteProvider.db.update(TodoItem.table, new_item);
    await getItems(item.category);
    log('Item toggle ${item.title}');
  }

  Future deleteItem(TodoItem item) async {
    await SQLiteProvider.db.delete(TodoItem.table, item);
    await getItems(item.category);
    log('Item delete ${item.title}');
  }

  Future editItem(TodoItem old_item, TodoItem new_item) async {
    if (old_item != new_item) {
      await SQLiteProvider.db.update(TodoItem.table, new_item);
      await getItems(new_item.category);
      log('Task edited ${old_item.title}');
    }
  }
}