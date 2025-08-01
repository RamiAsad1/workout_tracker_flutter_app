import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  late String name;

  late String description;

  late String weightType;

  late String mucleGroup;

  late String imagePath;
}
