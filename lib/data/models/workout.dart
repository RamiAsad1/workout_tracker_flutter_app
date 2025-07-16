import 'package:isar/isar.dart';

import 'package:workout_tracker/data/models/exercise.dart';

part 'workout.g.dart';

@collection
class Workout {
  Id id = Isar.autoIncrement;

  late String name;

  late String description;

  final exercises = IsarLinks<Exercise>();
}
