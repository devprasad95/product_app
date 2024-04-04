import '../entities/login_pin_entity.dart';
import '../repositories/pin_repository.dart';

class LoginPinUseCase {
  final PinRepository repository;

  LoginPinUseCase(this.repository);

  call(LoginPinEntity loginPinEntity) async {
    return await repository.loginPin(loginPinEntity);
  }
}