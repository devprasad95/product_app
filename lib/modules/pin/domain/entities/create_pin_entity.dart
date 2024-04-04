import 'package:equatable/equatable.dart';

class CreatePinEntity extends Equatable {
  final String pin;
  final String confirmPin;


  const CreatePinEntity({required this.pin, required this.confirmPin});

  @override
  List<Object?> get props => [pin, confirmPin];
}