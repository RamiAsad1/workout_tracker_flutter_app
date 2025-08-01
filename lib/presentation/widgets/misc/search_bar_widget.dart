import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';

import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';

class ExerciseSearchBar extends StatelessWidget {
  const ExerciseSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExerciseCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: AppLocalizations.of(context)!.searchBarHint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        ),
        onChanged: (value) => cubit.searchExercises(value),
      ),
    );
  }
}
