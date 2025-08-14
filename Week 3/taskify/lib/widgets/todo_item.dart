import 'package:flutter/material.dart';
import 'package:taskify/constants/colors.dart';
import 'package:taskify/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final onTodoChanged;
  final onDeleteItem;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: isDark ? Colors.grey[900] : Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Theme.of(context).primaryColor,
          size: 30,
        ),
        title: Text(
          todo.title.toString(),
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: tdRed,
            size: 30,
          ),
          onPressed: () {
            onDeleteItem(todo.id);
          },
        ),
      ),
    );
  }
}
