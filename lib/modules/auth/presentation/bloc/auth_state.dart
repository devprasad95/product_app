part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

class AuthLoggedOutState extends AuthState{}

class AuthSignedInState extends AuthState{}

class AuthSignedUpState extends AuthState{}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  

  @override
  List<Object> get props => [message];
}