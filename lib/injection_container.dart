import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
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
  initFeatures();
  initCore();
  await initExternal();
}

void initFeatures() {
  // Bloc
  sl.registerFactory(() => NumberTriviaBloc(
    concrete: sl() as GetConcreteNumberTrivia,
    random: sl() as GetRandomNumberTrivia,
    inputConverter: sl() as InputConverter
  ));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(
    sl() as NumberTriviaRepository
  ));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(
    sl() as NumberTriviaRepository
  ));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl() as NumberTriviaRemoteDataSource,
      localDataSource: sl() as NumberTriviaLocalDataSource, 
      networkInfo: sl() as NetworkInfo
    )
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl() as Client
    )
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl() as SharedPreferences
    )
  );

}

void initCore() {
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl() as DataConnectionChecker
    )
  );
}

Future<void> initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
