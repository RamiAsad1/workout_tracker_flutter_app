import 'package:isar/isar.dart';

import 'package:workout_tracker/data/models/exercise.dart';
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

  @override
  Future<void> updateExercise(Exercise exercise) async {
    await isar.writeTxn(() async {
      await isar.exercises.put(exercise);
    });

    await fetchExercises();
  }

  @override
  Future<void> deleteExercise(int id) async {
    await isar.writeTxn(() async {
      await isar.exercises.delete(id);
    });

    await fetchExercises();
  }
}
