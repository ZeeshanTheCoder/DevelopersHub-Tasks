import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taskify/constants/colors.dart';
import 'package:taskify/model/todo_model.dart';
import 'package:taskify/providers/theme_provider.dart';
import 'package:taskify/providers/todo_provider.dart';
import 'package:taskify/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchKeyword = "";

  void _showAddTaskDialog() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Add New Task"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter task name",
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                foregroundColor: tdBlue,
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  context.read<TodoProvider>().addTodo(controller.text.trim());
                  controller.clear();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                foregroundColor: tdBlue,
              ),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<TodoProvider>().deleteTodo(id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: tdRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Clear All Tasks"),
          content: const Text("Are you sure you want to delete all tasks?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: tdBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TodoProvider>().clearAll();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tdRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Delete All"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final todoProvider = context.watch<TodoProvider>();

    final todos = _searchKeyword.isEmpty
        ? todoProvider.todos
        : todoProvider.search(_searchKeyword);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: tdBlue),
              child: const Center(
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
              leading: const Icon(Icons.list_alt),
              title: const Text("All Tasks"),
              onTap: () {
                Navigator.pop(context);
                todoProvider.showAll();
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(todoProvider.showOnlyCompleted
                  ? "Show All Tasks"
                  : "Show Completed Tasks"),
              onTap: () {
                Navigator.pop(context);
                todoProvider.toggleFilter();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: tdRed),
              title: const Text(
                "Remove All Tasks",
                style: TextStyle(color: tdRed),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmDeleteAllDialog();
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.brightness_6),
              title: const Text("Dark Mode"),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) => themeProvider.toggleTheme(value),
            ),
          ],
        ),
      ),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _buildSearchBox(),
                Expanded(
                  child: todos.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Lottie.asset(
                                  'assets/animations/empty.json',
                                  height: 200,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "No Tasks Found",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: Text(
                                  todoProvider.showOnlyCompleted
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
                            for (TodoModel todo in todos.reversed)
                              TodoItem(
                                todo: todo,
                                onTodoChanged: (todo) => context
                                    .read<TodoProvider>()
                                    .toggleTodo(todo.id!),
                                onDeleteItem: (id) => _confirmDeleteDialog(id),
                              ),
                            const SizedBox(height: 50),
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

  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          onPressed: _showAddTaskDialog,
          icon: const Icon(Icons.add),
          iconSize: 30,
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchKeyword = value;
          });
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
            size: 20,
          ),
          prefixIconConstraints: const BoxConstraints(
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
}
