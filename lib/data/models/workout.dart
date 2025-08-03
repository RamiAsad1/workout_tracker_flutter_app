import 'package:isar/isar.dart';

import 'package:workout_tracker/data/models/exercise.dart';

part 'workout.g.dart';

@collection
class Workout {
  Workout({required this.name, required this.notes});

  Id id = Isar.autoIncrement;

  late String name;

  late String notes;

  final exercises = IsarLinks<Exercise>();
}
