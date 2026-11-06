# CourseFlow

## Description

CourseFlow is a simple Flutter app for viewing courses from local JSON, opening course details, and marking a weekly study task as completed for the current screen session.

## Technologies

- Flutter
- Dart
- Material UI
- Local JSON

## Flutter Version

- Flutter 3.47.9 (stable)
- Dart 3.13.7

(Run `flutter --version` locally to confirm your environment.)

## Features

- Bottom navigation: **Ana sayfa** (portal-style overview cards, static text) and **Dersler**
- Course listing (`GridView.builder`), search/filter (by course name)
- Course details (`Navigator.push` / `Navigator.pop`, `Course` via constructor)
- Local JSON data (`assets/data/courses.json`)
- Study task completion toggle on the detail screen (`StatefulWidget`)

## How to Run

```bash
flutter pub get
flutter run
```

Screenshots can be stored under `screenshots/` after you capture them from the emulator.
