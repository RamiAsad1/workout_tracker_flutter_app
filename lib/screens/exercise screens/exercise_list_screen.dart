import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/widgets/exercise/exercise_list_tile.dart';
import 'package:workout_tracker/screens/exercise%20screens/exercise_detail_screen.dart';

class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseCubit>().loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.allExercisesLabel),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.allExercises.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noExercisesFoundErrorMessage,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.allExercises.length,
            itemBuilder: (context, index) {
              final exercise = state.allExercises[index];

              return ExerciseListTile(
                exercise: exercise,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExerciseDetailsScreen(exercise: exercise),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
