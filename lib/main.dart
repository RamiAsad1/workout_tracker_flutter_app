import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:workout_tracker/app_root.dart';
import 'package:workout_tracker/data/models/exercise.dart';
import 'package:workout_tracker/data/models/workout.dart';
import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';
import 'package:workout_tracker/data/repository/exercise/isar_exercise_repository.dart';
import 'package:workout_tracker/data/repository/workout/isar_workout_repository.dart';
import 'package:workout_tracker/data/repository/workout/workout_repository.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/blocs/workout/workout_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    WorkoutSchema,
    ExerciseSchema,
  ], directory: dir.path);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WorkoutRepository>(
          create: (_) => IsarWorkoutRepository(isar),
        ),
        RepositoryProvider<ExerciseRepository>(
          create: (_) => IsarExerciseRepository(isar),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutCubit>(
            create: (context) =>
                WorkoutCubit(context.read<WorkoutRepository>()),
          ),
          BlocProvider<ExerciseCubit>(
            create: (context) =>
                ExerciseCubit(context.read<ExerciseRepository>()),
          ),
        ],
        child: MyApp(isar: isar),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isar});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppRoot(isar: isar),
      debugShowCheckedModeBanner: false,
    );
  }
}
