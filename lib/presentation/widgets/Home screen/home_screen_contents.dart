import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/blocs/workout/workout_cubit.dart';
import 'package:workout_tracker/presentation/widgets/form/add_workout_bottom_sheet.dart';
import 'package:workout_tracker/presentation/widgets/misc/search_bar_widget.dart';
import 'package:workout_tracker/screens/exercise%20screens/exercise_detail_screen.dart';

class HomeScreenContents extends StatefulWidget {
  const HomeScreenContents({super.key, required this.isar});

  final Isar isar;

  @override
  State<HomeScreenContents> createState() => _HomeScreenContentsState();
}

class _HomeScreenContentsState extends State<HomeScreenContents> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseCubit>().loadExercises();
    context.read<WorkoutCubit>().loadWorkouts();
  }

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
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = state.filteredExercises[index];
                    return ListTile(
                      title: Text(exercise.name),
                      subtitle: Text(exercise.description),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExerciseDetailsScreen(
                            exercise: exercise,
                            isEditing: false,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.myWorkoutsLabel,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (workouts.isEmpty)
              Center(
                child: Text(
                  AppLocalizations.of(context)!.noWorkoutsFoundErrorMessage,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return Dismissible(
                    key: ValueKey(workout.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      workouts.removeAt(index);
                      context.read<WorkoutCubit>().deleteWorkout(workout.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${workout.name} ${AppLocalizations.of(context)!.workoutDeletedLabel}',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: ListTile(
                      onTap: () async {
                        final workoutWithExercises = await widget.isar.workouts
                            .where()
                            .idEqualTo(workout.id)
                            .findFirst();

                        if (workoutWithExercises != null) {
                          await workoutWithExercises.exercises.load();
                          showModalBottomSheet(
                            // ignore: use_build_context_synchronously
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) =>
                                AddWorkoutBottomSheet(workout: workout),
                          );
                        }
                      },
                      title: Text(
                        workout.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(workout.notes),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => const AddWorkoutBottomSheet(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
