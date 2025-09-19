import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/language_constants.dart';
import 'package:workout_tracker/presentation/blocs/workout/workout_cubit.dart';
import 'package:workout_tracker/screens/home%20screen/home_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key, required this.isar});

  final Isar isar;

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_AppRootState>();
    state?.setLocale(newLocale);
  }

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  Locale? _locale;

  Future<void> _populateExercises() async {
    final repository = context.read<ExerciseRepository>();
    final existingExercises = await repository.fetchExercises();

    if (existingExercises.isEmpty) {
      final defaultExercises = [
        Exercise(
          name: "Bent Over Rows",
          description: "A back exercise using a barbell or dumbbells.",
          weightType: "weighted",
          muscleGroup: "Back",
          imagePath: "assets/images/bent-over-rows-anatomy.webp",
        ),
        Exercise(
          name: "Bicep Curls",
          description: "Isolation movement for the biceps.",
          weightType: "weighted",
          muscleGroup: "Biceps",
          imagePath: "assets/images/bicep-curls-anatomy.png",
        ),
        Exercise(
          name: "Calf Raises",
          description: "Targets calf muscles.",
          weightType: "bodyweight",
          muscleGroup: "Calves",
          imagePath: "assets/images/calf-raises-anatomy.webp",
        ),
        Exercise(
          name: "Dumbbell Bench Press",
          description: "Chest exercise using dumbbells.",
          weightType: "weighted",
          muscleGroup: "Chest",
          imagePath: "assets/images/db-benchpress-anatomy.png",
        ),
        Exercise(
          name: "Dumbbell Flys",
          description: "Chest isolation exercise.",
          weightType: "weighted",
          muscleGroup: "Chest",
          imagePath: "assets/images/db-flys-anatomy.webp",
        ),
        Exercise(
          name: "Deadlift",
          description: "Full-body compound lift.",
          weightType: "weighted",
          muscleGroup: "Back",
          imagePath: "assets/images/deadlift-anatomy.gif",
        ),
        Exercise(
          name: "Diamond Push-Ups",
          description: "Bodyweight triceps-focused push-up.",
          weightType: "bodyweight",
          muscleGroup: "Triceps",
          imagePath: "assets/images/diamonds-pu-anatomy.avif",
        ),
        Exercise(
          name: "Hammer Curls",
          description: "Variation of bicep curl.",
          weightType: "weighted",
          muscleGroup: "Biceps",
          imagePath: "assets/images/hammer-curls-anatomy.png",
        ),
        Exercise(
          name: "Lateral Raises",
          description: "Shoulder isolation with dumbbells.",
          weightType: "weighted",
          muscleGroup: "Shoulders",
          imagePath: "assets/images/lateral-raises-anatomy.webp",
        ),
        Exercise(
          name: "Lunges",
          description: "Leg exercise for quads and glutes.",
          weightType: "bodyweight",
          muscleGroup: "Legs",
          imagePath: "assets/images/lunges-anatomy.png",
        ),
        Exercise(
          name: "Overhead Press",
          description: "Shoulder compound movement.",
          weightType: "weighted",
          muscleGroup: "Shoulders",
          imagePath: "assets/images/overhead-press-anatomy.webp",
        ),
        Exercise(
          name: "Overhead Triceps Extension",
          description: "Isolation for triceps.",
          weightType: "weighted",
          muscleGroup: "Triceps",
          imagePath: "assets/images/overhead-triceps-extension-anatomy.webp",
        ),
        Exercise(
          name: "Push-Up",
          description: "Classic bodyweight chest exercise.",
          weightType: "bodyweight",
          muscleGroup: "Chest",
          imagePath: "assets/images/pu-anatomy.webp",
        ),
        Exercise(
          name: "Rear Delt Flys",
          description: "Isolation for rear delts.",
          weightType: "weighted",
          muscleGroup: "Shoulders",
          imagePath: "assets/images/rear-delt-flys-anatomy.png",
        ),
        Exercise(
          name: "Skullcrushers",
          description: "Triceps isolation with bar or dumbbells.",
          weightType: "weighted",
          muscleGroup: "Triceps",
          imagePath: "assets/images/skullcrushers-anatomy.webp",
        ),
        Exercise(
          name: "Squat",
          description: "Compound movement for legs and glutes.",
          weightType: "bodyweight",
          muscleGroup: "Legs",
          imagePath: "assets/images/squat-anatomy.png",
        ),
        Exercise(
          name: "Triceps Kickbacks",
          description: "Triceps isolation with dumbbells.",
          weightType: "weighted",
          muscleGroup: "Triceps",
          imagePath: "assets/images/triceps-kickbacks-anatomy.webp",
        ),
      ];

      for (final exercise in defaultExercises) {
        await repository.addExercise(exercise);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _populateExercises();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final locale = await getLocale();
      if (mounted) setState(() => _locale = locale);
    });
    context.read<WorkoutCubit>().loadWorkouts();
  }

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme lightScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Color(0xFF28A745),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF212121),
      error: Colors.red,
      onError: Colors.white,
    );

    final ColorScheme darkScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Color(0xFF00E676),
      onSecondary: Colors.black,
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE0E0E0),
      error: Colors.red.shade400,
      onError: Colors.black,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightScheme,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: lightScheme.secondary,
          unselectedItemColor: Colors.grey,
          backgroundColor: lightScheme.surface,
          selectedIconTheme: IconThemeData(color: lightScheme.secondary),
        ),
      ),
      darkTheme: ThemeData.from(colorScheme: darkScheme),
      themeMode: ThemeMode.system,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomeScreen(isar: widget.isar),
    );
  }
}
