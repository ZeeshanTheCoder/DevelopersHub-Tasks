# Taskify

Taskify is a simple and elegant To-Do List application built with Flutter. It helps you organize your day efficiently by managing tasks with features like add, delete, mark as complete, search, and theme toggle.

## Features

- Add new tasks
- Mark tasks as completed/incomplete
- Delete individual tasks
- Bulk delete all tasks
- Search tasks by keyword
- Toggle between Light and Dark themes
- Persistent data storage with Shared Preferences
- Splash Screen with animation

## Tech Stack

- Flutter
- Provider (State Management)
- Shared Preferences
- Lottie Animations

## What's New: Using Provider for State Management

Previously, Taskify used setState for managing state locally within widgets. Now, it has been refactored to use the Provider package for a more scalable and maintainable architecture.

### Benefits of Using Provider

- Centralized state management
- Better separation of concerns
- Easier to scale and maintain
- Reactive UI updates

## Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/taskify.git
   ```
2. **Navigate into the project directory:**
   ```sh
   cd taskify
   ```
3. **Install dependencies:**
   ```sh
   flutter pub get
   ```
4. **Run the app:**
   ```sh
   flutter run
   ```

## How It Works

### State Management

The app uses two primary providers:

- **ThemeProvider:** Manages light/dark theme toggle.
- **TodoProvider:** Manages the list of tasks, including add, delete, toggle complete, search, and bulk delete functionalities.

### Persistent Storage

Tasks are stored persistently using SharedPreferences, ensuring data remains after app restart.

### UI Components

- Splash Screen with animation
- Home Page with task list, search bar, and drawer for theme toggle and bulk actions
- Custom TodoItem widget for each task

## Future Enhancements

- Add task deadlines and reminders
- Implement task prioritization
- Sync with cloud storage
- Improve UI/UX

## License

This project is open-source under the MIT License.

> Made with ❤️ by **ZeeshanTheCoder**