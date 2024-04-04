import 'package:product_app/core/utils/local_values.dart';

import '../../../../core/error/exceptions.dart';
import '../models/pin_model.dart';

abstract class PinRemoteDataSource {
  Future createPin(PinModel pinModel);
  Future loginPin(PinModel pinModel);
}

class PinRemoteDataSourceImpl implements PinRemoteDataSource {
  @override
  Future createPin(PinModel pinModel) async {
    try {
      if (pinModel.pin == pinModel.confirmPin) {
        LocalValues.setPin(pinModel.pin);
      } else {
        throw PinRequestsException();
      }
    } on Exception {
      throw PinRequestsException();
    }
  }

  @override
  Future loginPin(PinModel pinModel) async {
    try {
      String? pin = await LocalValues.getPin();
      if (pin == pinModel.pin) {
        LocalValues.setPin(pinModel.pin);
      } else {
        throw PinRequestsException();
      }
    } on Exception {
      throw PinRequestsException();
    }
  }
}