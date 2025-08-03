import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/presentation/widgets/misc/background_container.dart';

class ExerciseListScreen extends StatelessWidget {
  const ExerciseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.allExercisesLabel),
        backgroundColor: Colors.black,
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
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.allExercises.length,
            itemBuilder: (context, index) {
              final exercise = state.allExercises[index];

              return ExerciseListTile(
                exercise: exercise,
                onTap: () {},
              ); // Todo: exercise details screen
            },
          );
        },
      ),
    );
  }
}

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;

  const ExerciseListTile({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            exercise.imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          exercise.name,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: GestureDetector(
          onTap: () {
            context.read<ExerciseCubit>().selectExercise(exercise);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green, width: 2),
            ),
            child: const Icon(Icons.add, color: Colors.green, size: 20),
          ),
        ),
      ),
    );
  }
}
