import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/language_constants.dart';
import 'package:workout_tracker/screens/Home%20screen/home_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

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
      final defaultExercises = [];

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
      home: const HomeScreen(),
    );
  }
}
