

import '../../domain/entities/create_pin_entity.dart';

class PinModel extends CreatePinEntity {
  const PinModel({required super.pin, required super.confirmPin});

  factory PinModel.fromJson(Map<String, dynamic> json) {
    return PinModel(pin: json['pin'], confirmPin: json['confirmPin']);
  }

  Map<String, dynamic> toJson() {
    return {'pin': pin, 'confirmPin': confirmPin};
  }
}