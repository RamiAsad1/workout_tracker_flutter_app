import 'package:isar/isar.dart';
import 'package:workout_tracker/data/isar%20models/exercise.dart';

import 'package:workout_tracker/data/isar%20models/workout.dart';
import 'package:workout_tracker/data/repository/workout/workout_repository.dart';

class IsarWorkoutRepository implements WorkoutRepository {
  final Isar isar;

  IsarWorkoutRepository(this.isar);

  @override
  Future<List<Workout>> fetchWorkouts() async {
    final workouts = await isar.workouts.where().findAll();

    for (var workout in workouts) {
      await workout.exercises.load();
    }

    return workouts;
  }

  @override
  Future<void> addWorkout(Workout workout, List<Exercise> exercises) async {
    await isar.writeTxn(() async {
      for (var exercise in exercises) {
        await isar.exercises.put(exercise);
      }
      await isar.workouts.put(workout);
      workout.exercises.addAll(exercises);
      await workout.exercises.save();
    });
  }

  @override
  Future<void> updateWorkout(Workout workout, List<Exercise> exercises) async {
    await isar.writeTxn(() async {
      await isar.workouts.put(workout);
      workout.exercises.clear();

      for (var exercise in exercises) {
        await isar.exercises.put(exercise);
        workout.exercises.add(exercise);
      }

      await workout.exercises.save();
    });
  }

  @override
  Future<void> deleteWorkout(int id) async {
    await isar.writeTxn(() async {
      await isar.workouts.delete(id);
    });
  }
}
