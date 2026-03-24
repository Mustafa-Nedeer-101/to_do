import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/data/repositories/notes_repository.dart';
import 'package:to_do/data/services/notes_local_service.dart';
import 'package:to_do/presentation/cubit/notes_cubit.dart';
import 'package:to_do/presentation/screens/home_page.dart';
import 'package:to_do/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('notes');

  // Create dependencies
  final localService = NotesLocalService();
  final NotesRepository repository = NotesRepositoryImpl(
    localService: localService,
  );

  // Starting Point of the Application
  runApp(ToDoApp(repository: repository));
}

class ToDoApp extends StatelessWidget {
  final NotesRepository repository;

  const ToDoApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(repository: repository)..loadNotes(),
      child: MaterialApp(
        title: "Notes App",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: NotesScreen(),
      ),
    );
  }
}
