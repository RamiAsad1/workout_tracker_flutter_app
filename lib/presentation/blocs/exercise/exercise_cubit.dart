import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository repository;

  ExerciseCubit(this.repository) : super(ExerciseInitial());

  Future<void> loadExercise() async {
    try {
      final exercises = await repository.fetchExercises();
      emit(ExerciseLoaded(exercises));
    } catch (e) {
      emit(ExerciseError('Failed to load exercises: $e')); //TODO: localize this
    }
  }

  Future<void> addExercise(Exercise exercise) async {
    try {
      await repository.addExercise(exercise);
      await loadExercise();
    } catch (e) {
      emit(ExerciseError('Failed to add exercises: $e'));
    }
  }

  Future<void> updateExercise(Exercise exercise) async {
    try {
      await repository.updateExercise(exercise);
      await loadExercise();
    } catch (e) {
      emit(ExerciseError('Failed to update exercises: $e'));
    }
  }

  Future<void> deleteExercise(int id) async {
    try {
      await repository.deleteExercise(id);
      await loadExercise();
    } catch (e) {
      emit(ExerciseError('Failed to delete exercises: $e'));
    }
  }
}
