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

- Course listing
- Course search/filter (by course name)
- Course details
- Navigation with `Navigator.push` / `Navigator.pop`
- Constructor-passed `Course` to the detail screen
- Local JSON data (`assets/data/courses.json`)
- Study task completion state (`StatefulWidget`)

## How to Run

```bash
flutter pub get
flutter run
```

Screenshots can be stored under `screenshots/` after you capture them from the emulator.
