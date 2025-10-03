import 'package:flutter/material.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/widgets/misc/build_info_card.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (exercise.imagePath.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  exercise.imagePath,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            const SizedBox(height: 24),
            BuildInfoCard(
              icon: Icons.info_outline,
              title: AppLocalizations.of(context)!.descriptionCardTitle,
              value: exercise.description,
              context: context,
            ),
            BuildInfoCard(
              icon: Icons.fitness_center,
              title: AppLocalizations.of(context)!.weightTypeCardTitle,
              value: exercise.weightType,
              context: context,
            ),
            BuildInfoCard(
              icon: Icons.accessibility_new,
              title: AppLocalizations.of(context)!.muscleGroupCardTitle,
              value: exercise.muscleGroup,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
