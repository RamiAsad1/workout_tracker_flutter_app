import 'package:flutter/material.dart';

import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/presentation/widgets/form/set_data_bottom_sheet.dart';
import 'package:workout_tracker/presentation/widgets/misc/background_container.dart';

class SetsScreen extends StatefulWidget {
  const SetsScreen({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<SetsScreen> createState() => _SetsScreenState();
}

class _SetsScreenState extends State<SetsScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.exercise.name} Sets',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: widget.exercise.sets.isEmpty
            ? Center(
                child: Text(
                  'No sets recorded yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              )
            : null,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (context) => const SetDataBottomSheet(),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
