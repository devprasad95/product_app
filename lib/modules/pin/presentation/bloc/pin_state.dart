part of 'pin_bloc.dart';

abstract class PinState extends Equatable {
  const PinState();
  
  @override
  List<Object> get props => [];
}

class LoadingState extends PinState {}

class ValidatePin extends PinState {}

class CreatePinState extends PinState {}

class LoginPinState extends PinState {}

class ErrorPinState extends PinState {
  final String message;
  ErrorPinState({required this.message});
  @override
  List<Object> get props => [message];
}
