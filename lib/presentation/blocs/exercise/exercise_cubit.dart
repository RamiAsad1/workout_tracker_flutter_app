import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';
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
        filteredExercises: [],
        isLoading: false,
      ),
    );
  }

  Future<void> selectExercise(Exercise exercise) async {
    final selectedExercises = List<Exercise>.from(state.selectedExercises);

    if (!selectedExercises.any((e) => e.id == exercise.id)) {
      selectedExercises.add(exercise);
      emit(state.copyWith(selectedExercises: selectedExercises));
    }
  }

  void removeExercise(Exercise exercise) {
    final updatedList = List<Exercise>.from(state.selectedExercises)
      ..remove(exercise);

    emit(state.copyWith(selectedExercises: updatedList));
  }

  void searchExercises(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredExercises: []));
    } else {
      final filtered = state.allExercises.where((exercise) {
        return exercise.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(state.copyWith(filteredExercises: filtered));
    }
  }

  void clearSelectedExercises() {
    emit(state.copyWith(selectedExercises: []));
  }

  Future<void> addSetToExercise(Exercise exercise, SetData setData) async {
    await repository.addSetToExercise(exercise, setData);

    final currentSets = Map<Exercise, List<SetData>>.from(state.exerciseSets);
    final exerciseSets = List<SetData>.from(currentSets[exercise] ?? []);
    exerciseSets.add(setData);
    currentSets[exercise] = exerciseSets;
    emit(state.copyWith(exerciseSets: currentSets));
  }

  Future<void> updateSetInExercise(
    Exercise exercise,
    int setIndex,
    SetData newSetData,
  ) async {
    await repository.updateSetInExercise(exercise, setIndex, newSetData);

    final currentSets = Map<Exercise, List<SetData>>.from(state.exerciseSets);
    final exerciseSets = List<SetData>.from(currentSets[exercise] ?? []);
    if (setIndex < exerciseSets.length) {
      exerciseSets[setIndex] = newSetData;
      currentSets[exercise] = exerciseSets;
      emit(state.copyWith(exerciseSets: currentSets));
    }
  }

  Future<void> deleteSetFromExercise(Exercise exercise, int setIndex) async {
    await repository.deleteSetFromExercise(exercise, setIndex);

    final currentSets = Map<Exercise, List<SetData>>.from(state.exerciseSets);
    final exerciseSets = List<SetData>.from(currentSets[exercise] ?? []);
    if (setIndex < exerciseSets.length) {
      exerciseSets.removeAt(setIndex);
      currentSets[exercise] = exerciseSets;
      emit(state.copyWith(exerciseSets: currentSets));
    }
  }
}
