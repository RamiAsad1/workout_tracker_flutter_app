import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repository/workout/workout_repository.dart';

part 'workout_state.dart';

//TODO: localize all of the error messages
class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository repository;

  WorkoutCubit(this.repository) : super(WorkoutInitial());

  Future<void> loadWorkouts() async {
    try {
      final workouts = await repository.fetchWorkouts();
      emit(WorkoutLoaded(workouts));
    } catch (e) {
      emit(WorkoutError('Failed to load workouts: $e'));
    }
  }

  Future<void> addWorkout(Workout workout) async {
    try {
      await repository.addWorkout(workout);
      await loadWorkouts();
    } catch (e) {
      emit(WorkoutError('Failed to add workout: $e'));
    }
  }

  Future<void> updateWorkout(Workout workout) async {
    try {
      await repository.updateWorkout(workout);
      await loadWorkouts();
    } catch (e) {
      emit(WorkoutError('Failed to update workout: $e'));
    }
  }

  Future<void> deleteWorkout(int id) async {
    try {
      await repository.deleteWorkout(id);
      await loadWorkouts();
    } catch (e) {
      emit(WorkoutError('Failed to delete workout: $e'));
    }
  }
}
