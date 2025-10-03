import 'package:flutter/material.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';

import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/set_data/set_data_cubit.dart';

class SetDataBottomSheet extends StatefulWidget {
  const SetDataBottomSheet({super.key});

  @override
  State<SetDataBottomSheet> createState() => _SetDataBottomSheetState();
}

class _SetDataBottomSheetState extends State<SetDataBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _repsController;
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final reps = _repsController.text;
      final weight = _weightController.text;

      Navigator.of(context).pop();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _weightController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.weightNameLabel,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              validator: (value) => value == null || value.isEmpty
                  ? AppLocalizations.of(context)!.workoutNameError
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _repsController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.repsNameLabel,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: Text(AppLocalizations.of(context)!.saveWorkoutBtnLabel),
              onPressed: _saveForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
