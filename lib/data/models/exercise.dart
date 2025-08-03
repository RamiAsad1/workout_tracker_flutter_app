import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
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
}
