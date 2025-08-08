import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/data/models/exercise.dart';

import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repository/workout/workout_repository.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository repository;

  WorkoutCubit(this.repository) : super(WorkoutState.initial());

  Future<void> loadWorkouts() async {
    emit(
      state.copyWith(
        allWorkouts: [],
        filteredWorkouts: [],
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final workouts = await repository.fetchWorkouts();
      emit(
        state.copyWith(
          allWorkouts: List<Workout>.from(workouts),
          filteredWorkouts: List<Workout>.from(workouts),
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load workouts, please try again later',
        ),
      );
    }
  }

  Future<void> addWorkout(Workout workout, List<Exercise> exercises) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.addWorkout(workout, exercises);
      await loadWorkouts();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to add workout, please try again later',
        ),
      );
    }
  }

  Future<void> updateWorkout(Workout workout) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.updateWorkout(workout);
      await loadWorkouts();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to update workout, please try again later',
        ),
      );
    }
  }

  Future<void> deleteWorkout(int id) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.deleteWorkout(id);
      await loadWorkouts();
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete workout, please try again later',
        ),
      );
    }
  }

  void searchWorkouts(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredWorkouts: state.allWorkouts));
    } else {
      final filtered = state.allWorkouts.where((workout) {
        return workout.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(state.copyWith(filteredWorkouts: filtered));
    }
  }
}
