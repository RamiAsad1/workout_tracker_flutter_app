# 🏋️ W-Track — Workout Tracker App

An offline-first cross-platform workout tracking app built with **Flutter** and **Isar**. W-Track lets users build custom workouts from a curated exercise library, log sets with weight and reps, and manage their training routines — all with zero internet dependency.

---

## ✨ Features

- Browse a **pre-loaded exercise library** (17 exercises across 7 muscle groups) with anatomy images
- **Search** exercises by name in real time
- Create and manage **custom workouts** with name, notes, and a selection of exercises
- **Edit or delete** existing workouts (swipe-to-delete support)
- Navigate into any workout to see its exercises and drill into **set logging** per exercise
- View exercise detail pages with anatomy image, description, weight type, and muscle group
- **Configurable units** (kg / lb) persisted across sessions
- **Bilingual support**: English and Arabic (full locale switching, persisted)
- Light and dark theme following the system setting
- Fully **offline** — no account, no internet required

---

## 🏗️ Architecture

The project follows a clean, layered architecture:

```
lib/
├── data/
│   ├── isar models/         # Isar collection classes (Workout, Exercise, SetData)
│   └── repository/          # Abstract interfaces + Isar implementations
│       ├── workout/
│       ├── exercise/
│       └── set_data/
├── presentation/
│   ├── blocs/               # Cubits for workout, exercise, and set data state
│   └── widgets/             # Reusable UI components (forms, tiles, misc)
├── screens/                 # All app screens grouped by feature
│   ├── Home screen/         # Home, History, Settings
│   ├── exercise screens/    # Exercise list, details, sets
│   └── workout_screens/     # Workout detail screen
├── l10n/                    # Localization files (EN + AR)
├── classes/                 # Helper classes (Language)
├── app_root.dart            # MaterialApp setup, theming, locale, DB seeding
└── main.dart                # Isar initialization + dependency injection
```

State management is handled entirely with **flutter_bloc** (Cubits). The repository pattern wraps all Isar operations behind abstract interfaces, keeping the presentation layer decoupled from the database.

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart SDK ^3.8.0) |
| State Management | flutter_bloc / Cubit |
| Local Database | Isar 3.x (NoSQL, offline-first) |
| Code Generation | isar_generator + build_runner |
| Localization | Flutter Intl (ARB files, EN + AR) |
| Persistence | shared_preferences (unit preference, locale) |
| Image Handling | image_picker, transparent_image |

---

## 📦 Data Models

**Exercise** — Isar collection
```
id, name, description, weightType, muscleGroup, imagePath
→ links: workouts[], sets[]
```

**Workout** — Isar collection
```
id, name, notes
→ links: exercises[]
```

**SetData** — Isar collection
```
id, reps, weight, timestamp
→ link: exercise
```

---

## 🏃 Exercise Library

The app seeds 17 exercises on first launch, covering:

| Muscle Group | Exercises |
|---|---|
| Back | Bent Over Rows, Deadlift |
| Biceps | Bicep Curls, Hammer Curls |
| Chest | Dumbbell Bench Press, Dumbbell Flys, Push-Up |
| Shoulders | Lateral Raises, Overhead Press, Rear Delt Flys |
| Triceps | Diamond Push-Ups, Overhead Triceps Extension, Skullcrushers, Triceps Kickbacks |
| Legs | Lunges, Squat |
| Calves | Calf Raises |

Each exercise includes an anatomy image (bundled as an asset) and is tagged as either `weighted` or `bodyweight`.

---

## 📱 Screens

| Screen | Description |
|---|---|
| Home Screen | Bottom nav with Workouts, History, and Settings tabs |
| Home (Workouts tab) | Searchable exercise list + workout list with add/edit/delete |
| Exercise Detail | Anatomy image, description, weight type, muscle group |
| Exercise List | Full exercise library, used when adding exercises to a workout |
| Workout Details | Exercise list within a workout; tap an exercise to log sets |
| Sets Screen | Per-exercise set log with add-set bottom sheet (reps + weight) |
| History Screen | Placeholder — planned workout history calendar |
| Settings Screen | Unit preference (kg/lb) and language switcher (EN/AR) |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.8.0

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/RamiAsad1/workout_tracker_flutter_app.git
   cd workout_tracker_flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (required for Isar schemas)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

> The exercise library is seeded automatically on first launch. No Firebase, no API keys, no `.env` file needed.

---

## 🗺️ Planned Features

- Workout history screen with a calendar view of active training days
- Set history per exercise (sorted by date)
- Firebase sync for cloud backup (planned)

---

## 🌍 Localization

The app supports **English** and **Arabic** out of the box. Language can be switched from the Settings screen and is persisted across sessions. To add a new language, add a new `.arb` file under `lib/l10n/` and register the locale in `app_root.dart`.

---

## 📄 License

This project is for portfolio and learning purposes.
