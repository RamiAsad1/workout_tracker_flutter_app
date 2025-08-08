// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get historyLabel => 'History';

  @override
  String get workoutLabel => 'Workouts';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get exerciseLoadError => 'Failed to load exercises';

  @override
  String get exerciseAddError => 'Failed to add exercise';

  @override
  String get exerciseDeleteError => 'Failed to delete exercise';

  @override
  String get exerciseUpdateError => 'Failed to update exercise';

  @override
  String get workoutLoadError => 'Failed to load workouts';

  @override
  String get workoutAddError => 'Failed to add workout';

  @override
  String get workoutDeleteError => 'Failed to delete workout';

  @override
  String get workoutUpdateError => 'Failed to update workout';

  @override
  String get searchBarHint => 'Search exercises...';

  @override
  String get allExercisesLabel => 'All Exercises';

  @override
  String get noExercisesFoundErrorMessage => 'No exercises found';

  @override
  String get myWorkoutsLabel => 'My Workouts';

  @override
  String get noWorkoutsFoundErrorMessage =>
      'You have no workouts yet.\nStart by adding some exercises!';

  @override
  String lastSessionLabel(String date) {
    return 'Last session was: $date';
  }

  @override
  String get addWorkoutLabel => 'Add Workout';

  @override
  String get workoutNameLabel => 'Workout Name';

  @override
  String get workoutNameError => 'Enter a workout name';

  @override
  String get workoutNotesLabel => 'Notes';

  @override
  String get addExerciseBtnLabel => 'Add Exercise';

  @override
  String get saveWorkoutBtnLabel => 'Save';

  @override
  String get exerciseAddedLabel => 'Exercise added';

  @override
  String get exerciseDeletedLabel => 'Exercise deleted';

  @override
  String get workoutSavedLabel => 'Workout saved';

  @override
  String get workoutDeletedLabel => 'Workout deleted';
}
