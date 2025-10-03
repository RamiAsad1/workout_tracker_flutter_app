import 'package:isar/isar.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';

abstract class SetDataRepository {
  Future<void> addSet(Exercise exercise, SetData set);
  Future<void> updateSet(SetData set);
  Future<void> deleteSet(Id setId);
  Future<List<SetData>> getSetsByExercise(Exercise exercise);
  Future<SetData?> getSetById(Id setId);
}
