import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = TodoModel.todoList();
  List<TodoModel> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
    _loadTodoList();
  }

  void _loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');

    if (todosString != null) {
      final List decoded = json.decode(todosString);
      final loadedTodos = decoded.map((e) => TodoModel.fromJson(e)).toList();

      setState(() {
        todoList.clear();
        todoList.addAll(loadedTodos.cast<TodoModel>());
        _foundTodo = todoList;
      });
    } else {
      _foundTodo = todoList;
    }
  }

  void _saveData() async {
    final sp = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(todoList.map((e) => e.toJson()).toList());
    sp.setString('todos', encodedData);
  }

  void _handleChange(TodoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    _saveData();
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
    _saveData();
  }

  void _addTodoItem(String todo) {
    setState(() {
      todoList.add(
          TodoModel(id: DateTime.now().millisecond.toString(), title: todo));
    });
    _saveData();
  }

  void _runFilter(String enteredkeyword) {
    List<TodoModel> results = [];
    if (enteredkeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.title!.toLowerCase().contains(enteredkeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: _foundTodo.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/animations/empty.json',
                                  repeat: true,
                                  reverse: false,
                                  animate: true,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "No Todos Found",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: Text(
                                  "All Todos",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                  ),
                                ),
                              ),
                            ),
                            for (TodoModel todo in _foundTodo.reversed)
                              TodoItem(
                                todo: todo,
                                onTodoChanged: _handleChange,
                                onDeleteItem: _deleteTodoItem,
                              ),
                            SizedBox(height: 50),
                          ],
                        ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: "Add a new Todo Item",
                        hintStyle:
                            Theme.of(context).inputDecorationTheme.hintStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_todoController.text.isNotEmpty) {
                        _addTodoItem(_todoController.text);
                        _todoController.text = '';
                      }
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      minimumSize: Size(60, 60),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            minHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search Text here',
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/avatar.jpg',
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
