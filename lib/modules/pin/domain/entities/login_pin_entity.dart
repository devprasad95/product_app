import 'package:equatable/equatable.dart';

class LoginPinEntity extends Equatable {
  final String pin;

  const LoginPinEntity({required this.pin});

  @override
  List<Object?> get props => [pin];
}