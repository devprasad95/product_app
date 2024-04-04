import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failures.dart';
import '../entities/sign_in_entity.dart';
import '../entities/sign_up_entity.dart';

abstract class AuthRepository{
  Future<Either<Failure, UserCredential>> signUp(SignUpEntity signUp);
  Future<Either<Failure, UserCredential>> signIn(SignInEntity signIn);
  Future<Either<Failure, void>> signOut();
  Stream<User?> getAuthStateChanges();
}