import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';

class AuthStateChangesUseCase {
  final AuthRepository repository;

  AuthStateChangesUseCase(this.repository);

  Stream<User?> call() {
    return repository.getAuthStateChanges();
  }
}