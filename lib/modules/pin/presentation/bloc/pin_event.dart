part of 'pin_bloc.dart';

abstract class PinEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckPinInEvent extends PinEvent {}

class CreatePinEvent extends PinEvent {
  final CreatePinEntity createPinEntity;
  CreatePinEvent({required this.createPinEntity});
  @override
  List<Object> get props => [createPinEntity];
}

class LoginPinEvent extends PinEvent {
  final LoginPinEntity loginPinEntity;
  LoginPinEvent({required this.loginPinEntity});
  @override
  List<Object> get props => [loginPinEntity];
}
