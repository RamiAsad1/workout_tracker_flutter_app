import 'package:workout_tracker/data/isar%20models/set_data.dart';

class SetDataState {
  final bool isLoading;
  final String? errorMessage;
  final List<SetData> sets;

  SetDataState({
    this.isLoading = false,
    this.errorMessage,
    this.sets = const [],
  });

  factory SetDataState.initial() {
    return SetDataState(isLoading: false, errorMessage: null, sets: []);
  }

  SetDataState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<SetData>? sets,
  }) {
    return SetDataState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      sets: sets ?? this.sets,
    );
  }
}
