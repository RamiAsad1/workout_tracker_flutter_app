import 'package:isar/isar.dart';
import 'package:workout_tracker/data/models/workout.dart';

part 'exercise.g.dart';

@Collection()
@Name('exercises')
class Exercise {
  Exercise({
    required this.name,
    required this.description,
    required this.weightType,
    required this.muscleGroup,
    this.reps,
    this.sets,
    this.weight,
    required this.imagePath,
  });

  Id id = Isar.autoIncrement;

  late String name;
  late String description;
  late String weightType;
  late String muscleGroup;
  int? reps;
  int? sets;
  double? weight;
  late String imagePath;

  final workouts = IsarLinks<Workout>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'weightType': weightType,
      'muscleGroup': muscleGroup,
      'reps': reps,
      'sets': sets,
      'weight': weight,
      'imagePath': imagePath,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      description: json['description'],
      weightType: json['weightType'],
      muscleGroup: json['muscleGroup'],
      reps: json['reps'],
      sets: json['sets'],
      weight: json['weight'],
      imagePath: json['imagePath'],
    )..id = json['id'];
  }
}
