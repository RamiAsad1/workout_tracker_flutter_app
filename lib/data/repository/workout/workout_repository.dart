import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> fetchWorkouts();
  Future<void> addWorkout(Workout workout, List<Exercise> exercises);
  Future<void> updateWorkout(Workout workout, List<Exercise> exercises);
  Future<void> deleteWorkout(int id);
}
