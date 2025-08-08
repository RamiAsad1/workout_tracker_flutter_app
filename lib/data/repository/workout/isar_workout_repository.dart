import 'package:isar/isar.dart';
import 'package:workout_tracker/data/models/exercise.dart';

import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repository/workout/workout_repository.dart';

class IsarWorkoutRepository implements WorkoutRepository {
  final Isar isar;

  IsarWorkoutRepository(this.isar);

  final List<Workout> _workouts = [];

  @override
  Future<List<Workout>> fetchWorkouts() async {
    List<Workout> fetchedWorkouts = await isar.workouts.where().findAll();

    for (final workout in fetchedWorkouts) {
      await workout.exercises.load();
    }

    _workouts.clear();
    _workouts.addAll(fetchedWorkouts);

    return _workouts;
  }

  @override
  Future<void> addWorkout(Workout workout, List<Exercise> exercises) async {
    await isar.writeTxn(() async {
      workout.exercises.addAll(exercises);
      await isar.workouts.put(workout);
      await workout.exercises.save();
    });
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    await isar.writeTxn(() async {
      await isar.workouts.put(workout);
    });
  }

  @override
  Future<void> deleteWorkout(int id) async {
    await isar.writeTxn(() async {
      await isar.workouts.delete(id);
    });
  }
}
