import 'package:flutter/material.dart';

import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen({
    super.key,
    required this.exercise,
    required this.isEditing,
  });

  final Exercise exercise;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    int _repsDone = 0;
    int _weight = 0;
    // List<Map<String, dynamic>> repsHistory = [];

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
              title: AppLocalizations.of(context)!.descriptionCardTitle,
              value: exercise.description,
              context: context,
            ),
            _buildInfoCard(
              icon: Icons.fitness_center,
              title: AppLocalizations.of(context)!.weightTypeCardTitle,
              value: exercise.weightType,
              context: context,
            ),
            _buildInfoCard(
              icon: Icons.accessibility_new,
              title: AppLocalizations.of(context)!.muscleGroupCardTitle,
              value: exercise.muscleGroup,
              context: context,
            ),
            // if (exercise.reps != null)
            //   _buildInfoCard(
            //     icon: Icons.format_list_numbered,
            //     title: 'Reps',
            //     value: '${exercise.reps}',
            //     context: context,
            //   ),
            if (exercise.weight != null)
              _buildInfoCard(
                icon: Icons.scale,
                title: AppLocalizations.of(context)!.weightCardTitle,
                value: '${exercise.weight} kg',
                context: context,
              ),
            if (isEditing) ...[
              const SizedBox(height: 24),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.repsDoneLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSaved: (reps) => _repsDone = int.tryParse(reps ?? '') ?? 0,
                validator: (value) =>
                    value == null || value.isEmpty || value == '0'
                    ? AppLocalizations.of(context)!.repsDoneError
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.weightCardTitle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSaved: (weight) => _weight = int.tryParse(weight ?? '') ?? 0,
                validator: (value) =>
                    value == null || value.isEmpty || value == '0'
                    ? AppLocalizations.of(context)!.weightError
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {}, // TODO: Implement save functionality
                label: Text(
                  AppLocalizations.of(context)!.saveWorkoutBtnLabel,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              // const SizedBox(height: 16),
              // SizedBox(
              //   height: 200,
              //   child: ListView.builder(
              //     itemCount: repsHistory.length,
              //     itemBuilder: (context, index) {
              //       final repEntry =
              //           repsHistory[index];
              //       return Card(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         margin: const EdgeInsets.symmetric(vertical: 4),
              //         elevation: 2,
              //         child: ListTile(
              //           contentPadding: const EdgeInsets.symmetric(
              //             horizontal: 16,
              //             vertical: 8,
              //           ),
              //           title: Text(
              //             '${repEntry['reps']} reps',
              //             style: const TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //           subtitle: Text(
              //             _formatDate(repEntry['date']),
              //             style: TextStyle(color: Colors.grey[600]),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    //TODO: make this a reusable widget
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
