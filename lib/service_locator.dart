import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/features/todo/data/data_sources/local/local_data_source.dart';
import 'package:todo_list/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list/features/todo/domain/usecases/get_todo_by_id_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_list/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:todo_list/features/todo/presentation/bloc/bloc/todo_bloc.dart';

import 'features/todo/data/repositories/default_todo_repository.dart';

final serviceLocator = GetIt.instance;
void init() {
  // Bloc
  serviceLocator.registerFactory(() => TodoBloc(
      getTodoByIdUsecase: serviceLocator(),
      removeTodoUsecase: serviceLocator(),
      insertTodoUsecase: serviceLocator()));

  // Usecases
  serviceLocator
      .registerLazySingleton(() => GetTodoByIdUsecase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => RemoveTodoUsecase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => InsertTodoUsecase(serviceLocator()));

  // Repositories
  serviceLocator.registerLazySingleton<TodoRepository>(
      () => DefaultTodoRepository(serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<LocalDataSource>(
      () => DefaulLocalDataSource(serviceLocator()));

  // DB
  serviceLocator.registerLazySingleton<HiveInterface>(
      () => Hive);
}
