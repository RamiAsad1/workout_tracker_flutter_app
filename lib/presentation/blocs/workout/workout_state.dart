part of 'workout_cubit.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<Workout> workouts;

  const WorkoutLoaded(this.workouts);

  @override
  List<Object> get props => [workouts];
}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError(this.message);

  @override
  List<Object> get props => [message];
}
