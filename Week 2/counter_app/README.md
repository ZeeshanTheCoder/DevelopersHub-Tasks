
# Counter App

A simple Flutter app to increment and decrement a counter, featuring a custom button widget and a custom mobile app icon.

## Features
- Counter functionality (increment/decrement/reset)
- Custom button widget
- Mobile app icon updated (using `flutter_launcher_icons`)
- Responsive UI

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart

### Installation & Run
1. Clone the repository:
   ```sh
   git clone https://github.com/ZeeshanTheCoder/DevelopersHub-Tasks
   ```
2. Navigate to the project directory:
   ```sh
   cd counter_app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

### App Icon
The mobile app icon has been changed using the `flutter_launcher_icons` package. You can update the icon by replacing `assets/images/logo.png` and running:
```sh
flutter pub run flutter_launcher_icons:main
```

## Project Structure
```
lib/
  main.dart                # App entry point
  counter_page.dart        # Counter page UI and logic
  utility/
    custom_button.dart     # Custom button widget
assets/
  images/
    logo.png               # App logo
android/                   # Android platform files
ios/                       # iOS platform files
web/                       # Web platform files
```


## License
This project is licensed under the MIT License.

> Made with ❤️ by **ZeeshanTheCoder**