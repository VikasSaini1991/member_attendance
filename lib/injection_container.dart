import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_client.dart';
import 'core/config/app_config.dart';
import 'core/network/network_info.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'features/attendance/data/repositories/attendance_repository_impl.dart';
import 'features/attendance/domain/repositories/attendance_repository.dart';
import 'features/attendance/domain/usecases/get_mps.dart';
import 'features/attendance/domain/usecases/verify_otp.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core - Theme
  sl.registerFactory(() => ThemeBloc(sharedPreferences: sl()));

  //! Features - Attendance
  // Bloc
  sl.registerFactory(
    () => AttendanceBloc(
      getMps: sl(),
      verifyOtp: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetMps(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  // Repository
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DioClient(sl()));
  sl.registerLazySingleton(() => AppConfig());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}
