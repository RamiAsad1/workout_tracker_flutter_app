part of 'exercise_cubit.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;

  const ExerciseLoaded(this.exercises);

  @override
  List<Object> get props => [exercises];
}

class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object> get props => [message];
}
