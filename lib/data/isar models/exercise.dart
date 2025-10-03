import 'package:isar/isar.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';
import 'package:workout_tracker/data/isar%20models/workout.dart';

part 'exercise.g.dart';

@Collection()
@Name('exercises')
class Exercise {
  Exercise({
    required this.name,
    required this.description,
    required this.weightType,
    required this.muscleGroup,
    required this.imagePath,
  });

  Id id = Isar.autoIncrement;

  late String name;
  late String description;
  late String weightType;
  late String muscleGroup;
  late String imagePath;

  final workouts = IsarLinks<Workout>();
  final sets = IsarLinks<SetData>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'weightType': weightType,
      'muscleGroup': muscleGroup,
      'imagePath': imagePath,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      description: json['description'],
      weightType: json['weightType'],
      muscleGroup: json['muscleGroup'],
      imagePath: json['imagePath'],
    )..id = json['id'];
  }
}
