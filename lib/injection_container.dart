import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:product_app/core/internet_connection/internet_connection_status.dart';
import 'package:product_app/core/internet_connection/internet_connection_status_impl.dart';
import 'package:product_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:product_app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:product_app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:product_app/modules/auth/domain/use_cases/auth_state_changes_use_case.dart';
import 'package:product_app/modules/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:product_app/modules/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:product_app/modules/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:product_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:product_app/modules/pin/data/data_source/pin_data_source.dart';
import 'package:product_app/modules/pin/data/repositories/pin_repository_impl.dart';
import 'package:product_app/modules/pin/domain/repositories/pin_repository.dart';
import 'package:product_app/modules/pin/domain/usecases/create_pin_use_case.dart';
import 'package:product_app/modules/pin/domain/usecases/login_pin_use_case.dart';
import 'package:product_app/modules/pin/presentation/bloc/pin_bloc.dart';
import 'package:product_app/modules/product_management/data/data_sources/product_source.dart';
import 'package:product_app/modules/product_management/data/repositories/product_repository_impl.dart';
import 'package:product_app/modules/product_management/domain/repositories/product_repository.dart';
import 'package:product_app/modules/product_management/domain/use_cases/product_list_usecase.dart';
import 'package:product_app/modules/product_management/domain/use_cases/product_usecase.dart';
import 'package:product_app/modules/product_management/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

// Bloc
  sl.registerFactory(
    () => AuthBloc(
      authStateChangesUseCase: sl(),
      signInUseCase: sl(),
      signOutUseCase: sl(),
      signUpUseCase: sl(),
    ),
  );
  sl.registerFactory(
      () => PinBloc(createPinUseCase: sl(), loginPinUseCase: sl()));
  sl.registerFactory(
      () => ProductBloc(productCase: sl(), productListUseCase: sl()));

// Usecases
  sl.registerLazySingleton(() => AuthStateChangesUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => CreatePinUseCase(sl()));
  sl.registerLazySingleton(() => LoginPinUseCase(sl()));
  sl.registerLazySingleton(() => ProductCase(sl()));
  sl.registerLazySingleton(() => ProductListUseCase(sl()));

// Repository
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(
          internetConnectionStatus: sl(), authRemoteDataSource: sl()));
  sl.registerLazySingleton<PinRepository>(
      () => PinRepositoryImp(pinRemoteDataSource: sl()));
  sl.registerLazySingleton<ProductRepository>(() =>
      ProductRepositoryImp(networkInfo: sl(), productRemoteDataSource: sl()));

// Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<PinRemoteDataSource>(
      () => PinRemoteDataSourceImpl());
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());

//! Core
  sl.registerLazySingleton<InternetConnectionStatus>(() => InternetConnectionStatusImpl(sl()));

//! External
  sl.registerLazySingleton(() => InternetConnection());
}
