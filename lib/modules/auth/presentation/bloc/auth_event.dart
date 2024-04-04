part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {

  @override
  List<Object> get props => [];
}


class SignUpEvent extends AuthEvent {
  final SignUpEntity signUpEntity;
  SignUpEvent({required this.signUpEntity});
  @override
  List<Object> get props => [signUpEntity];
} 

class SignInEvent extends AuthEvent {
  final SignInEntity signInEntity;
   SignInEvent({required this.signInEntity});
  @override
  List<Object> get props => [signInEntity];
}

class SignOutEvent extends AuthEvent {}

class AuthStateChangesEvent extends AuthEvent {
  AuthStateChangesEvent(User? user);
}