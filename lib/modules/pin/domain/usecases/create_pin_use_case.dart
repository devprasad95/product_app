import '../entities/create_pin_entity.dart';
import '../repositories/pin_repository.dart';

class CreatePinUseCase {
  final PinRepository repository;

  CreatePinUseCase(this.repository);

  call(CreatePinEntity createPinEntity) async {
    return await repository.createPin(createPinEntity);
  }
}