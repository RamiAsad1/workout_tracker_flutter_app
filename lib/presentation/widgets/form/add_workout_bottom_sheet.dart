import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/workout/workout_cubit.dart';
import 'package:workout_tracker/screens/exercise%20screens/exercise_list_screen.dart';

class AddWorkoutBottomSheet extends StatefulWidget {
  const AddWorkoutBottomSheet({super.key});

  @override
  State<AddWorkoutBottomSheet> createState() => _AddWorkoutBottomSheetState();
}

class _AddWorkoutBottomSheetState extends State<AddWorkoutBottomSheet> {
  final List<Exercise> _selectedExercises = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveWorkout() async {
    if (_formKey.currentState!.validate()) {
      context.read<WorkoutCubit>().addWorkout(
        Workout(name: _nameController.text, notes: _notesController.text),
        _selectedExercises,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 12,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.addWorkoutLabel,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              textAlign: TextAlign.start,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.workoutNameLabel,
              ),
              validator: (value) => value == null || value.isEmpty
                  ? AppLocalizations.of(context)!.workoutNameError
                  : null,
            ),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.workoutNotesLabel,
              ),
              maxLines: 3,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.fitness_center),
              label: Text(AppLocalizations.of(context)!.addExerciseBtnLabel),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExerciseListScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: Text(AppLocalizations.of(context)!.saveWorkoutBtnLabel),
              onPressed: _saveWorkout,
            ),
          ],
        ),
      ),
    );
  }
}
