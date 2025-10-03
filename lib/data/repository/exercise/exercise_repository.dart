import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercises();
  Future<void> addExercise(Exercise exercise);
  Future<void> addSetToExercise(Exercise exercise, SetData set);
  Future<void> updateSetInExercise(
    Exercise exercise,
    int setIndex,
    SetData set,
  );
  Future<void> deleteSetFromExercise(Exercise exercise, int setIndex);
}
