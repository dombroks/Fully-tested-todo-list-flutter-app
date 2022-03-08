import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/features/todo/data/data_sources/local/local_data_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'features/todo/data/repositories/default_todo_repository.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

final sl = GetIt.instance;
Future<void> init() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
// DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;
    hive.init(directory.path);
    
    return hive;
  });

// Bloc
  sl.registerFactory(() => TodoBloc(
      getTodoByIdUsecase: sl(),
      removeTodoUsecase: sl(),
      insertTodoUsecase: sl(),
      getAllTodosUsecase: sl()));

  // Data sources
  sl.registerLazySingleton<LocalDataSource>(() => DefaulLocalDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<TodoRepository>(() => DefaultTodoRepository(sl()));

  // Usecases
  sl.registerLazySingleton(() => GetTodoByIdUsecase(sl()));
  sl.registerLazySingleton(() => RemoveTodoUsecase(sl()));
  sl.registerLazySingleton(() => InsertTodoUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTodosUsecase(sl()));
}
