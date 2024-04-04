import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;


  const SignUpEntity( {required this.email, required this.password,required this.confirmPassword,});

  @override
  List<Object?> get props => [email, password,confirmPassword];
}