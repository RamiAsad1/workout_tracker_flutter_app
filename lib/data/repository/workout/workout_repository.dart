import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/models/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> fetchWorkouts();
  Future<void> addWorkout(Workout workout, List<Exercise> exercises);
  Future<void> updateWorkout(Workout workout);
  Future<void> deleteWorkout(int id);
}
