import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/constants/colors.dart';
import 'package:taskify/model/todo_model.dart';
import 'package:taskify/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;

  HomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = TodoModel.todoList();
  List<TodoModel> _foundTodo = [];

  bool _showOnlyCompleted = false;

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
    _loadTodoList();
  }

  // load shared_preference
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

  // save data in shared_preference
  void _saveData() async {
    final sp = await SharedPreferences.getInstance();
    final String encodedData =
        json.encode(todoList.map((e) => e.toJson()).toList());
    sp.setString('todos', encodedData);
  }

  // handle all task
  void _handleChange(TodoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    _saveData();
    _runFilter("");
  }

  // deleter task
  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
    _saveData();
    _runFilter("");
  }

  // add task
  void _addTodoItem(String todo) {
    setState(() {
      todoList.add(TodoModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(), title: todo));
    });
    _saveData();
    _runFilter("");
  }

  // search
  void _runFilter(String enteredKeyword) {
    List<TodoModel> results = [];

    if (_showOnlyCompleted) {
      results = todoList
          .where((item) =>
              item.isDone &&
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    } else {
      results = todoList
          .where((item) =>
              item.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  // Completed Tasks
  void _toggleCompletedView(bool showCompleted) {
    setState(() {
      _showOnlyCompleted = showCompleted;
      _runFilter("");
    });
  }

  // Add Todo Dialog Box
  void _showAddTaskDialog() {
    TextEditingController dialogController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Add New Task"),
          content: TextField(
            controller: dialogController,
            decoration: InputDecoration(
              hintText: "Enter task name",
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: tdBlue,
              ),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (dialogController.text.trim().isNotEmpty) {
                  _addTodoItem(dialogController.text.trim());
                  dialogController.clear();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: tdBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  // Delete Task confirmation Dialog Box
  void _confirmDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: tdBlue,
              ),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteTodoItem(id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: tdBGColor,
                backgroundColor: tdRed,
              ),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // Delete All Task confirmation Dialog Box
  void _confirmDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Clear All Tasks"),
          content: Text("Are you sure you want to delete all tasks?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: tdBlue,
              ),
              child: Text(
                "Cancel",
                style: TextStyle(color: tdBlue),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todoList.clear();
                  _foundTodo.clear();
                });
                _saveData();
                Navigator.pop(context);
                _runFilter("");
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: tdBGColor,
                backgroundColor: tdRed,
              ),
              child: Text(
                "Delete All",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: tdBlue),
              child: Center(
                child: Text(
                  "Taskify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text("All Tasks"),
              onTap: () {
                Navigator.pop(context);
                _toggleCompletedView(false);
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text(_showOnlyCompleted
                  ? "Show All Tasks"
                  : "Show Completed Tasks"),
              onTap: () {
                Navigator.pop(context);
                _toggleCompletedView(!_showOnlyCompleted);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever, color: tdRed),
              title: Text("Remove All Tasks", style: TextStyle(color: tdRed)),
              onTap: () {
                Navigator.pop(context);
                _confirmDeleteAllDialog();
              },
            ),
            SwitchListTile(
              secondary: Icon(Icons.brightness_6),
              title: Text("Dark Mode"),
              value: widget.isDarkMode,
              onChanged: (value) {
                widget.onThemeToggle(value);
              },
            ),
          ],
        ),
      ),
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
                                  "No Tasks Found",
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
                                  _showOnlyCompleted
                                      ? "Completed Tasks"
                                      : "All Tasks",
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
                                onDeleteItem: (id) => _confirmDeleteDialog(id),
                              ),
                            SizedBox(height: 50),
                          ],
                        ),
                ),
              ],
            ),
          ),
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
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showAddTaskDialog,
          icon: Icon(Icons.add),
          iconSize: 30,
        ),
      ],
    );
  }
}
