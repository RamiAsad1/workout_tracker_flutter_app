import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:workout_tracker/app_root.dart';
import 'package:workout_tracker/data/isar%20models/exercise.dart';
import 'package:workout_tracker/data/isar%20models/set_data.dart';
import 'package:workout_tracker/data/isar%20models/workout.dart';
import 'package:workout_tracker/data/repository/exercise/exercise_repository.dart';
import 'package:workout_tracker/data/repository/exercise/isar_exercise_repository.dart';
import 'package:workout_tracker/data/repository/set_data/isar_set_data_repository.dart';
import 'package:workout_tracker/data/repository/set_data/set_data_repository.dart';
import 'package:workout_tracker/data/repository/workout/isar_workout_repository.dart';
import 'package:workout_tracker/data/repository/workout/workout_repository.dart';
import 'package:workout_tracker/presentation/blocs/exercise/exercise_cubit.dart';
import 'package:workout_tracker/presentation/blocs/set_data/set_data_cubit.dart';
import 'package:workout_tracker/presentation/blocs/workout/workout_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    WorkoutSchema,
    ExerciseSchema,
    SetDataSchema,
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
        RepositoryProvider<SetDataRepository>(
          create: (_) => IsarSetDataRepository(isar),
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
          BlocProvider<SetDataCubit>(
            create: (context) =>
                SetDataCubit(context.read<SetDataRepository>()),
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
