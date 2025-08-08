import 'package:flutter/material.dart';
import 'package:workout_tracker/data/models/exercise.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailsScreen({super.key, required this.exercise});

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
            _buildInfoCard(
              icon: Icons.info_outline,
              title: 'Description',
              value: exercise.description,
              context: context,
            ),
            _buildInfoCard(
              icon: Icons.fitness_center,
              title: 'Weight Type',
              value: exercise.weightType,
              context: context,
            ),
            _buildInfoCard(
              icon: Icons.accessibility_new,
              title: 'Muscle Group',
              value: exercise.muscleGroup,
              context: context,
            ),
            if (exercise.sets != null)
              _buildInfoCard(
                icon: Icons.repeat,
                title: 'Sets',
                value: '${exercise.sets}',
                context: context,
              ),
            if (exercise.reps != null)
              _buildInfoCard(
                icon: Icons.format_list_numbered,
                title: 'Reps',
                value: '${exercise.reps}',
                context: context,
              ),
            if (exercise.weight != null)
              _buildInfoCard(
                icon: Icons.scale,
                title: 'Weight',
                value: '${exercise.weight} kg',
                context: context,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required BuildContext context,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
