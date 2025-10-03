import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/widgets/misc/background_container.dart';

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final bool isAdded;
  final VoidCallback onTap;

  const ExerciseListTile({
    super.key,
    required this.exercise,
    required this.isAdded,
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  exercise.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              exercise.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  exercise.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.sports, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      exercise.muscleGroup,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: isAdded
                ? null
                : GestureDetector(
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green[50] : Colors.grey[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        isSelected ? Icons.check : Icons.add,
                        color: isSelected ? Colors.green : Colors.grey[600],
                        size: 18,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
