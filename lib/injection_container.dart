import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'core/presentation/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      concrete: sl(),
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      inputConverter: sl(),
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      random: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
    () => GetConcreteNumberTrivia(sl())
  );
  sl.registerLazySingleton(
    // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
    () => GetRandomNumberTrivia(sl())
  );

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      localDataSource: sl(),
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      networkInfo: sl(),
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      client: sl()
    ),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      sharedPreferences: sl()
    ),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      // ignore: ARGUMENT_TYPE_NOT_ASSIGNABLE
      sl()
    )
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
