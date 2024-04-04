import '../entities/create_pin_entity.dart';
import '../entities/login_pin_entity.dart';

abstract class PinRepository {
  createPin(CreatePinEntity createPinEntity);
  loginPin(LoginPinEntity loginPinEntity);
}