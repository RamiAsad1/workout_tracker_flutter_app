import 'package:isar/isar.dart';
import 'package:workout_tracker/data/isar%20models/exercise.dart';

part 'set_data.g.dart';

@Collection()
class SetData {
  Id id = Isar.autoIncrement;

  late int reps;
  late double weight;
  late DateTime timestamp;

  final exercise = IsarLink<Exercise>();

  SetData({required this.reps, required this.weight})
    : timestamp = DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'reps': reps,
    'weight': weight,
    'timestamp': timestamp.toIso8601String(),
  };

  factory SetData.fromJson(Map<String, dynamic> json) => SetData(
    reps: json['reps'],
    weight: json['weight'],
    // timestamp: DateTime.parse(json['timestamp']), re-add if it casues issues
  );
}
