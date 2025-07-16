import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  late String name;

  late String weightType;

  late int sets;

  late int reps;

  late double weight;
}
