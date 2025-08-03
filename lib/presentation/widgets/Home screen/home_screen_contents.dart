import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/blocs/workout/workout_cubit.dart';
import 'package:workout_tracker/presentation/widgets/form/add_workout_bottom_sheet.dart';
import 'package:workout_tracker/presentation/widgets/misc/search_bar_widget.dart';

class HomeScreenContents extends StatelessWidget {
  const HomeScreenContents({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = context.watch<WorkoutCubit>().state.allWorkouts;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExerciseSearchBar(),
            const SizedBox(height: 10),
            BlocBuilder<ExerciseCubit, ExerciseState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.filteredExercises.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(
                        context,
                      )!.noExercisesFoundErrorMessage,
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = state.filteredExercises[index];
                    return ListTile(
                      title: Text(exercise.name),
                      subtitle: Text(exercise.description),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.myWorkoutsLabel,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (workouts.isEmpty)
              Center(
                child: Text(
                  AppLocalizations.of(context)!.noWorkoutsFoundErrorMessage,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return ListTile(
                    title: Text(workout.name),
                    subtitle: Text(workout.notes),
                  );
                },
              ),
            FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (context) => const AddWorkoutBottomSheet(),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
