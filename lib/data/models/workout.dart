import 'package:isar/isar.dart';
import 'package:workout_tracker/data/models/exercise.dart';

part 'workout.g.dart';

@Collection()
@Name('workouts')
class Workout {
  Workout({required this.name, required this.notes});

  Id id = Isar.autoIncrement;
  late String name;
  late String notes;

  final exercises = IsarLinks<Exercise>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'notes': notes,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    final workout = Workout(name: json['name'], notes: json['notes'])
      ..id = json['id'];

    if (json['exercises'] != null) {
      final exerciseList = (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList();
      workout.exercises.addAll(exerciseList);
    }

    return workout;
  }
}
