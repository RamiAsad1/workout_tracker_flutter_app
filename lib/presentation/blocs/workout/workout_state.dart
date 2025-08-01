part of 'workout_cubit.dart';

class WorkoutState {
  final List<Workout> allWorkouts;
  final List<Workout> filteredWorkouts;
  final bool isLoading;
  final String? errorMessage;

  const WorkoutState({
    required this.allWorkouts,
    required this.filteredWorkouts,
    required this.isLoading,
    this.errorMessage,
  });

  factory WorkoutState.initial() {
    return const WorkoutState(
      allWorkouts: [],
      filteredWorkouts: [],
      isLoading: false,
      errorMessage: null,
    );
  }

  WorkoutState copyWith({
    List<Workout>? allWorkouts,
    List<Workout>? filteredWorkouts,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WorkoutState(
      allWorkouts: allWorkouts ?? this.allWorkouts,
      filteredWorkouts: filteredWorkouts ?? this.filteredWorkouts,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
