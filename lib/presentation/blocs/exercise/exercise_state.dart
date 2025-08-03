part of 'exercise_cubit.dart';

class ExerciseState {
  final List<Exercise> allExercises;
  final List<Exercise> selectedExercises;
  final List<Exercise> filteredExercises;
  final bool isLoading;

  ExerciseState({
    required this.allExercises,
    required this.selectedExercises,
    required this.filteredExercises,
    required this.isLoading,
  });

  factory ExerciseState.initial() {
    return ExerciseState(
      allExercises: [],
      selectedExercises: [],
      filteredExercises: [],
      isLoading: false,
    );
  }

  ExerciseState copyWith({
    List<Exercise>? allExercises,
    List<Exercise>? selectedExercises,
    List<Exercise>? filteredExercises,
    bool? isLoading,
  }) {
    return ExerciseState(
      allExercises: allExercises ?? this.allExercises,
      selectedExercises: selectedExercises ?? this.selectedExercises,
      filteredExercises: filteredExercises ?? this.filteredExercises,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
