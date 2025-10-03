import 'package:isar/isar.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';
import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';

class IsarExerciseRepository implements ExerciseRepository {
  final Isar isar;

  IsarExerciseRepository(this.isar);

  final List<Exercise> _exercises = [];

  @override
  Future<void> addExercise(Exercise exercise) async {
    await isar.writeTxn(() async {
      await isar.exercises.put(exercise);
    });

    await fetchExercises();
  }

  @override
  Future<List<Exercise>> fetchExercises() async {
    List<Exercise> fetchedExercises = await isar.exercises.where().findAll();
    _exercises.clear();
    _exercises.addAll(fetchedExercises);

    return _exercises;
  }

  // Todo: remove these methods later if not needed
  // @override
  // Future<void> updateExercise(Exercise exercise) async {
  //   await isar.writeTxn(() async {
  //     await isar.exercises.put(exercise);
  //   });

  //   await fetchExercises();
  // }

  // @override
  // Future<void> deleteExercise(int id) async {
  //   await isar.writeTxn(() async {
  //     await isar.exercises.delete(id);
  //   });

  //   await fetchExercises();
  // }

  @override
  Future<void> addSetToExercise(Exercise exercise, SetData setData) async {
    await isar.writeTxn(() async {
      await isar.setDatas.put(setData);

      final ex = await isar.exercises.get(exercise.id);
      if (ex != null) {
        ex.sets.add(setData);
        await ex.sets.save();
      }
    });
  }

  @override
  Future<void> updateSetInExercise(
    Exercise exercise,
    int setIndex,
    SetData newSetData,
  ) async {
    await isar.writeTxn(() async {
      final ex = await isar.exercises.get(exercise.id);
      if (ex != null) {
        await ex.sets.load();
        final setsList = ex.sets.toList();
        if (setIndex < ex.sets.length) {
          final oldSet = setsList[setIndex];

          final updatedSet = SetData(
            reps: newSetData.reps,
            weight: newSetData.weight,
          )..id = oldSet.id;

          await isar.setDatas.put(updatedSet);
        }
      }
    });
  }

  @override
  Future<void> deleteSetFromExercise(Exercise exercise, int setIndex) async {
    await isar.writeTxn(() async {
      final ex = await isar.exercises.get(exercise.id);
      if (ex != null) {
        await ex.sets.load();
        final setsList = ex.sets.toList();
        if (setIndex < ex.sets.length) {
          final setToDelete = setsList[setIndex];
          setsList.removeAt(setIndex);
          await ex.sets.save();

          await isar.setDatas.delete(setToDelete.id);
        }
      }
    });
  }
}
