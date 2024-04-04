import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_app/core/error/failures.dart';
import 'package:product_app/core/internet_connection/internet_connection_status.dart';
import 'package:product_app/modules/auth/data/data_source/auth_data_source.dart';
import 'package:product_app/modules/auth/domain/entities/sign_in_entity.dart';
import 'package:product_app/modules/auth/domain/entities/sign_up_entity.dart';
import 'package:product_app/modules/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../models/sign_in_model.dart';
import '../models/sign_up_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final InternetConnectionStatus internetConnectionStatus;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.internetConnectionStatus});
  @override
  Stream<User?> getAuthStateChanges() {
    return authRemoteDataSource.authStateChanges;
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signIn) async{
     if (!await internetConnectionStatus.isConnected) {
      return Left(OfflineFailure());
    } else {
      try {
        final userCredential = await authRemoteDataSource.signIn(
          SignInModel(email: signIn.email, password: signIn.password),
        );
        return Right(userCredential);
      } on NoUserException {
        return Left(NoUserFailure());
      } on WrongPasswordException {
        return Left(WrongPasswordFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async{
     if (!await internetConnectionStatus.isConnected) {
      return Left(OfflineFailure());
    } else {
      try {
        await authRemoteDataSource.signOut();
        return const Right(null);
      } catch (_) {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUp) async {
    if (!await internetConnectionStatus.isConnected) {
      return Left(OfflineFailure());
    } else {
      try {
        final signUpModel = SignUpModel(
          email: signUp.email,
          password: signUp.password,
          confirmPassword: signUp.confirmPassword,
        );
        final userCredential = await authRemoteDataSource.signUp(signUpModel);
        return Right(userCredential);
      } on WeekPassWordException {
        return Left(WeekPassWordFailure());
      } on AlreadyExistingAccountException {
        return Left(AlreadyExistingAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }
}
