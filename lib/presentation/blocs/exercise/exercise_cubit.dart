import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository repository;

  ExerciseCubit(this.repository) : super(ExerciseState.initial());

  Future<void> loadExercises() async {
    emit(state.copyWith(isLoading: true));
    final exercises = await repository.fetchExercises();
    emit(
      state.copyWith(
        allExercises: exercises,
        filteredExercises: exercises,
        isLoading: false,
      ),
    );
  }

  void searchExercises(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredExercises: state.allExercises));
    } else {
      final filtered = state.allExercises.where((exercise) {
        return exercise.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(state.copyWith(filteredExercises: filtered));
    }
  }
}
