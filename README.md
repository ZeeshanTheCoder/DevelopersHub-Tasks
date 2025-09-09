# DevelopersHub Tasks --- Flutter Internship

## Project Overview

A comprehensive Flutter application series built over two cycles:

**Cycle 1 (Weeks 1--3):** Basic UI, state management, navigation,
persistence with SharedPreferences, and a Task Management app.

**Cycle 2 (Weeks 4--6):** API integration, Firebase Authentication and
Firestore, state management using Provider, final optimizations, and
extended features.

### Technologies Used

- Flutter, Dart
- SharedPreferences (local storage)
- http package (API calls & JSON parsing)
- Firebase Authentication & Firestore
- Provider for state management
- Flutter built-in widgets, Icons, navigation, animations

## Timeline & Features

### Week 1 -- Basic Flutter UI & Navigation

- Set up Flutter development environment (IDE, project init).
- Built a login screen with TextFormField (email, password), a
  FlatButton, and a "Forgot Password?" Text.
- Structured UI using Column, Row, Container, etc.
- Implemented navigation to Home Screen via Navigator.push().\
  **Deliverable:** A minimal working app with login screen and
  navigation.

### Week 2 -- State Management & Local Persistence

- Utilized setState() to manage UI changes. Example: A counter app
  with increment/decrement.
- Integrated SharedPreferences to persist the counter value across app
  restarts.
- Developed a simple to-do list: adding tasks, displaying them in a
  ListView, and storing tasks in SharedPreferences.\
  **Deliverable:** Functional to-do list app with persistent storage.

### Week 3 -- Final Project (Cycle 1): Task Management App UI Enhancements

- Combined previous learnings into a cohesive task manager: add,
  delete, mark tasks complete.
- Ensured data persistence via SharedPreferences.
- Added a custom AppBar with title and action button for adding tasks.
- Enhanced visuals using icons from the Icons library.
- Tested navigation, storage, and UI flows; debugged as needed.\
  **Deliverable:** Full Task Management app; README with setup
  instructions (Cycle 1 completion).

### Week 4 -- API Integration & Networking

- Used the http package to fetch data from a public API (e.g.,
  JSONPlaceholder).
- Parsed JSON responses, displayed lists via ListView.
- Built a User Profile screen that fetches and displays name, email,
  and profile picture.
- Added loading spinners and error handling for network requests.\
  **Deliverable:** Networking-capable Flutter app showcasing API data
  with robust UX.

### Week 5 -- Firebase Authentication & Firestore

- Integrated Firebase into the project: enabled Email/Password Auth.
- Developed Login and Signup screens powered by Firebase Auth.
- On successful login, navigated to a User Profile screen displaying
  data.
- Stored and retrieved user details (name, email) in Cloud Firestore.\
  **Deliverable:** App with Firebase Auth and Firestore integration;
  updated codebase and README.

### Week 6 -- State Management with Provider & Final Enhancements

- Refactored Task Management app to use Provider instead of setState()
  for state handling (tasks: add, delete, update).
- Ensured real-time UI updates on state changes.
- Optimized performance and architecture.
- Added basic UI/UX animations to improve interactivity.\
  **Deliverable:** Fully Provider‑powered Task Management app with
  enhanced architecture, performance, and animations; complete README.

## What I Learned

Over the course of this internship, I significantly improved my skills
in the following areas:

### Flutter Development Fundamentals

- Flutter project structure and folder organization.
- Building responsive UIs using widgets like Column, Row, Container,
  TextFormField, ListView, and more.
- Implementing screen navigation with Navigator.push().

### State Management

- Using setState() for local UI state handling.
- Migrating to Provider for scalable and reactive state management.

### Persistent Local Storage

- Saving and retrieving simple data using SharedPreferences.
- Building local to-do and task management apps with persistent
  storage.

### API Integration

- Sending HTTP requests using the http package.
- Parsing JSON responses and mapping them into Dart models.
- Handling errors and loading states gracefully.

### Firebase Integration

- Setting up Firebase with Flutter for both Android and iOS platforms.
- Implementing Email/Password Authentication.
- Saving and retrieving user data using Cloud Firestore.

### Clean Code and Architecture

- Organizing files using separation of concerns (e.g., models,
  services, providers, UI).
- Following best practices for performance and reusability.

### UI/UX Enhancements

- Using custom AppBars, action buttons, icons, and splash screens.
- Implementing animations and transitions for better user experience.

## Project Highlights

- Multiple working apps across different Flutter modules.
- Real-world features like login/signup, local and cloud data storage,
  and live updates.
- Clean and modular code for easy maintenance and future expansion.
- Video walkthroughs showcasing app usage and functionality.
- Bonus Challenges: Splash Screen (Cycle 1), Firebase Exploration.

## Challenges Faced

Some of the challenges I overcame during the internship included: -
Handling nested async functions with SharedPreferences and Firestore. -
Debugging layout issues across different screen sizes. - Ensuring state
updates with Provider reflect instantly across widgets. - Firebase setup
(SHA keys, configurations) and solving common integration errors. -
Balancing code simplicity with functionality and performance.

## Future Improvements

If continued, I would like to: - Implement Push Notifications using
Firebase Cloud Messaging (FCM). - Replace Provider with Riverpod or Bloc
for advanced state management. - Use SQLite for more complex offline
storage. - Add unit testing and widget testing for better
maintainability. - Deploy the app to Google Play Store as a portfolio
project.

## Links

- GitHub Repo: [DevelopersHub Tasks -- GitHub](https://github.com/ZeeshanTheCoder/DevelopersHub-Tasks.git)
- Setup Instructions: Provided in each project/module folder.

> Made with ❤️ by **ZeeshanTheCoder**
