
# Taskify

Taskify is a simple Flutter application for managing your daily tasks. It demonstrates basic state management, custom widgets, and navigation in Flutter.

## 🚀 Features

### ✅ Task Management
- Add new tasks easily
- Mark tasks as **done** or **undone**
- Delete individual tasks
- Remove **all tasks** with a single tap
- View a list of **completed tasks**

### 🔍 Real-Time Search
- Instantly search through your tasks using a responsive **search bar**

### 💾 Persistent Storage
- All tasks and theme preferences are saved locally using **SharedPreferences**
- Data is retained even after app is closed

### 🎨 UI & Experience
- Clean and modern user interface
- Custom color palette for better visual experience
- Smooth and **beautiful Lottie animations** when the task list is empty
- Updated app icon using `flutter_launcher_icons`

### 🌙 Theme Customization
- Toggle between **Light** and **Dark** themes
- Theme preference is saved locally using SharedPreferences
## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio or VS Code

### Installation

1. Clone the repository:
	```sh
	git clone https://github.com/ZeeshanTheCoder/DevelopersHub-Tasks.git
	```
2. Navigate to the project directory:
	```sh
	cd taskify
	```
3. Get dependencies:
	```sh
	flutter pub get
	```
4. Run the app:
	```sh
	flutter run
	```

## Project Structure

- `lib/`
  - `main.dart` - Entry point of the app
  - `constants/colors.dart` - App color constants
  - `model/todo_model.dart` - To-do item model
  - `screens/` - App screens (home, splash)
  - `widgets/todo_item.dart` - Custom widget for to-do items
- `assets/`
  - `animations/` - Lottie animation files
  - `images/` - App images (logo, avatar)
- `test/` - Widget tests

## Usage

1. Launch the app on an emulator or device.
2. Add new tasks and view them on the home page.
3. Explore the splash screen and custom widgets.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License.

> Made with ❤️ by **ZeeshanTheCoder**