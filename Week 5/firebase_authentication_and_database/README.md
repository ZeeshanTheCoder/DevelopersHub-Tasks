# Firebase Authentication and Database

A Flutter project demonstrating Firebase Authentication and Firestore Database integration.

## Features

- User authentication with Firebase (sign in, sign up, sign out)
- Firestore database integration
- Platform support: Android, iOS, Web

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A Firebase project (see [Firebase Console](https://console.firebase.google.com/))

### Setup

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd firebase_authentication_and_database
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Firebase Configuration:**
   - Android: Place your `google-services.json` in `android/app/`.
   - iOS: Place your `GoogleService-Info.plist` in `ios/Runner/`.
   - Web: Configuration is handled in [`lib/firebase_options.dart`](lib/firebase_options.dart).

4. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/` - Main Dart source files
  - `pages/` - App pages (e.g., Home, Login)
  - `firebase_options.dart` - Firebase configuration
- `android/` - Android-specific files
- `ios/` - iOS-specific files
- `web/` - Web-specific files

## Dependencies

- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [flutter_lints](https://pub.dev/packages/flutter_lints)

## License

See [build/flutter_assets/NOTICES](build/flutter_assets/NOTICES) for licenses of dependencies.

---

**Note:** This project is for educational purposes. Do not use API keys or credentials from this repository in production apps.

> Made with ❤️ by **ZeeshanTheCoder**