import 'package:isar/isar.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';
import 'package:workout_tracker/data/repository/set_data/set_data_repository.dart';

class IsarSetDataRepository implements SetDataRepository {
  final Isar isar;

  IsarSetDataRepository(this.isar);

  @override
  Future<void> addSet(Exercise exercise, SetData setData) async {
    await isar.writeTxn(() async {
      await isar.setDatas.put(setData);
      setData.exercise.value = exercise;
      await setData.exercise.save();
    });
  }

  @override
  Future<List<SetData>> getSetsByExercise(Exercise exercise) async {
    return await isar.setDatas
        .where()
        .filter()
        .exercise((q) => q.idEqualTo(exercise.id))
        .findAll();
  }

  @override
  Future<SetData?> getSetById(Id setId) async {
    return await isar.setDatas.get(setId);
  }

  @override
  Future<void> updateSet(SetData setData) async {
    await isar.writeTxn(() async {
      await isar.setDatas.put(setData);
    });
  }

  @override
  Future<void> deleteSet(Id setId) async {
    await isar.writeTxn(() async {
      await isar.setDatas.delete(setId);
    });
  }
}
