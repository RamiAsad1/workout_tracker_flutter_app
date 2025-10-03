import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import 'package:workout_tracker/data/isar models/exercise.dart';
import 'package:workout_tracker/data/isar models/set_data.dart';
import 'package:workout_tracker/data/repository/set_data/set_data_repository.dart';
import 'package:workout_tracker/presentation/blocs/set_data/set_data_state.dart';

class SetDataCubit extends Cubit<SetDataState> {
  final SetDataRepository repository;

  SetDataCubit(this.repository) : super(SetDataState());

  Future<void> addSet(Exercise exercise, SetData setData) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.addSet(exercise, setData);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Failed to add set: $e'),
      );
    }
  }

  Future<void> loadSetsByExercise(Exercise exercise) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final sets = await repository.getSetsByExercise(exercise);
      emit(state.copyWith(isLoading: false, sets: sets));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load sets: $e',
        ),
      );
    }
  }

  Future<void> updateSet(SetData setData) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.updateSet(setData);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to update set: $e',
        ),
      );
    }
  }

  Future<void> deleteSet(Id setId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await repository.deleteSet(setId);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to delete set: $e',
        ),
      );
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
