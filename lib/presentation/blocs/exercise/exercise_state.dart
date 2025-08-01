part of 'exercise_cubit.dart';

class ExerciseState {
  final List<Exercise> allExercises;
  final List<Exercise> filteredExercises;
  final bool isLoading;

  ExerciseState({
    required this.allExercises,
    required this.filteredExercises,
    required this.isLoading,
  });

  factory ExerciseState.initial() {
    return ExerciseState(
      allExercises: [],
      filteredExercises: [],
      isLoading: false,
    );
  }

  ExerciseState copyWith({
    List<Exercise>? allExercises,
    List<Exercise>? filteredExercises,
    bool? isLoading,
  }) {
    return ExerciseState(
      allExercises: allExercises ?? this.allExercises,
      filteredExercises: filteredExercises ?? this.filteredExercises,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
