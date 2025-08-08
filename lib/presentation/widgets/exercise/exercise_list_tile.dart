import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/widgets/misc/background_container.dart';

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  const ExerciseListTile({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = context
        .watch<ExerciseCubit>()
        .state
        .selectedExercises
        .contains(exercise);

    return BackgroundContainer(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            exercise.imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          exercise.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            context.read<ExerciseCubit>().selectExercise(exercise);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${exercise.name} ${AppLocalizations.of(context)!.exerciseAddedLabel}',
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.green, size: 20)
                : const Icon(Icons.add, color: Colors.green, size: 20),
          ),
        ),
      ),
    );
  }
}
