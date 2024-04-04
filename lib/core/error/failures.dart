import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoUserFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AlreadyExistingAccountFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class WeekPassWordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmailVerificationFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WrongPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnmatchedPassWordFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class NotLoggedInFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TooManyRequestsFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PinFailure extends Failure {
  @override
  List<Object?> get props => [];
}
