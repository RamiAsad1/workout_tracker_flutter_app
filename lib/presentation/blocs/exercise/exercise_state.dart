part of 'exercise_cubit.dart';

class ExerciseState {
  final List<Exercise> allExercises;
  final List<Exercise> selectedExercises;
  final List<Exercise> filteredExercises;
  final Map<Exercise, List<SetData>> exerciseSets;
  final bool isLoading;

  ExerciseState({
    required this.allExercises,
    required this.selectedExercises,
    required this.filteredExercises,
    required this.exerciseSets,
    required this.isLoading,
  });

  factory ExerciseState.initial() {
    return ExerciseState(
      allExercises: [],
      selectedExercises: [],
      filteredExercises: [],
      exerciseSets: {},
      isLoading: false,
    );
  }

  ExerciseState copyWith({
    List<Exercise>? allExercises,
    List<Exercise>? selectedExercises,
    List<Exercise>? filteredExercises,
    Map<Exercise, List<SetData>>? exerciseSets,
    bool? isLoading,
  }) {
    return ExerciseState(
      allExercises: allExercises ?? this.allExercises,
      selectedExercises: selectedExercises ?? this.selectedExercises,
      filteredExercises: filteredExercises ?? this.filteredExercises,
      exerciseSets: exerciseSets ?? this.exerciseSets,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
