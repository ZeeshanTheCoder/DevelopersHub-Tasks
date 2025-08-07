# Todo App

A simple Flutter Todo application to add, delete, mark tasks as done, and save the tasks locally using SharedPreferences.

## Features
- Add new todo items.
- Mark todo items as done or undone.
- Delete todo items.
- Search todo items using a search bar.
- Persistent storage of todos using local device storage (SharedPreferences).
- Beautiful animations for empty todo list using Lottie.
- Mobile app icon updated (using `flutter_launcher_icons`)
- Responsive UI
- Clean and modern UI with custom colors.

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart

### Installation & Run
1. Clone the repository:
   ```sh
   git clone https://github.com/ZeeshanTheCoder/DevelopersHub-Tasks.git
   ```
2. Navigate to the project directory:
   ```sh
   cd todo_app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Project Structure
```
lib/
├── constants/
│   └── colors.dart         # App color constants
├── model/
│   └── todo_model.dart     # Todo data model with JSON serialization
├── screens/
│   └── home_page.dart      # Main screen showing todo list, search and input
├── widgets/
│   └── todo_item.dart      # Widget to display individual todo item
└── main.dart               # Entry point of the app
assets/
├── animations/
│   └── empty.json          # Lottie animation for empty todo list
└── images/
    └── avatar.jpeg         # User avatar image shown in app bar
```

## Code Overview

### main.dart
- Runs the app and loads HomePage as the home screen.

### home_page.dart
- Stateful widget maintaining todo list state.
- Loads todos from SharedPreferences on init.
- Saves todos to local storage on add, delete, or toggle done status.
- Provides UI for:
  - Search box to filter todos.
  - Displaying todo items or an empty animation.
  - Adding new todos via a text input field and a '+' button.
- Uses TodoModel for todo data structure.
- Uses TodoItem widget to display individual todo tasks.

### todo_item.dart
- Stateless widget that shows a todo item with:
  - Checkbox icon to mark done/undone.
  - Title text with line-through decoration if done.
  - Delete button to remove the todo.

### todo_model.dart
- Todo data model with id, title, and isDone status.
- Static sample todo list for initial data.
- JSON serialization methods (toJson and fromJson) to persist todos.

### colors.dart
- Contains app-specific color constants for consistent UI styling.

## Dependencies
- flutter
- shared_preferences — for local persistent storage.
- lottie — for animations.
- flutter_launcher_icons - for mobile icon

## License
This project is licensed under the MIT License.

> Made with ❤️ by [ZeeshanTheCoder](https://github.com/ZeeshanTheCoder)