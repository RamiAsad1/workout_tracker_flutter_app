import 'package:workout_tracker/data/models/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercises();
  Future<void> addExercise(Exercise exercise);
  Future<void> updateExercise(Exercise exercise);
  Future<void> deleteExercise(int id);
}
