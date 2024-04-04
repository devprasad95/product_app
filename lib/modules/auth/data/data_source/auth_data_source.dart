import 'package:firebase_auth/firebase_auth.dart';
import 'package:product_app/modules/auth/data/models/sign_in_model.dart';
import '../../../../core/error/exceptions.dart';
import '../models/sign_up_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signUp(SignUpModel signUp);
  Future<UserCredential> signIn(SignInModel signIn);
  Future<void> signOut();
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<UserCredential> signUp(SignUpModel signUp) async {
    try {
      await _firebaseAuth.currentUser?.reload();
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: signUp.email,
        password: signUp.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeekPassWordException();
      } else if (e.code == 'email-already-in-use') {
        throw AlreadyExistingAccountException();
      } else {
        throw ServerException();
      }
    }
  }
  
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  
  @override
  Future<UserCredential> signIn(SignInModel signIn) async{
    try {
      await _firebaseAuth.currentUser?.reload();
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: signIn.email,
        password: signIn.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw NoUserException();
      } else if (e.code == 'wrong-password'){
        throw WrongPasswordException();
      }
       else {
        throw ServerException();
      }
    }
  }
  
  @override
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
}