import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/create_pin_entity.dart';
import '../../domain/entities/login_pin_entity.dart';
import '../../domain/repositories/pin_repository.dart';
import '../data_source/pin_data_source.dart';
import '../models/pin_model.dart';

class PinRepositoryImp implements PinRepository {
  final PinRemoteDataSource pinRemoteDataSource;

  PinRepositoryImp({required this.pinRemoteDataSource});

  @override
  createPin(CreatePinEntity createPinEntity) async {
    try {
      final pinModel = PinModel(
          pin: createPinEntity.pin, confirmPin: createPinEntity.confirmPin);
      final pin = await pinRemoteDataSource.createPin(pinModel);
      return Right(pin);
    } on PinRequestsException {
      return Left(PinFailure());
    }
  }

  @override
  loginPin(LoginPinEntity loginPinEntity) async {
    try {
      final pinModel = PinModel(pin: loginPinEntity.pin, confirmPin: "");
      final pin = await pinRemoteDataSource.loginPin(pinModel);
      return Right(pin);
    } on PinRequestsException {
      return Left(PinFailure());
    }
  }
}