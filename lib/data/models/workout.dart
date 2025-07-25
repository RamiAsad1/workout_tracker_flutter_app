import 'package:isar/isar.dart';

import 'package:workout_tracker/data/models/exercise.dart';

part 'workout.g.dart';

@collection
class Workout {
  Id id = Isar.autoIncrement;

  late String name;

  late DateTime date;

  final exercises = IsarLinks<Exercise>();
}

@embedded
class WorkoutExercise {
  late int exerciseId;

  late int reps;

  late int sets;

  double? weight;
}
