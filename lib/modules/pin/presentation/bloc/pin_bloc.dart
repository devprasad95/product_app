
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constant_values.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/create_pin_entity.dart';
import '../../domain/entities/login_pin_entity.dart';
import '../../domain/usecases/create_pin_use_case.dart';
import '../../domain/usecases/login_pin_use_case.dart';

part 'pin_event.dart';
part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final CreatePinUseCase createPinUseCase;
  final LoginPinUseCase loginPinUseCase;

  PinBloc({
    required this.createPinUseCase,
    required this.loginPinUseCase,
  }) : super(ValidatePin()) {
    on<CreatePinEvent>((event, emit) async {
      emit(LoadingState());
      final failureOrUserCredential =
          await createPinUseCase(event.createPinEntity);
      emit(eitherToState(failureOrUserCredential, CreatePinState()));
    });

    on<LoginPinEvent>((event, emit) async {
      emit(LoadingState());
      final failureOrUserCredential =
          await loginPinUseCase(event.loginPinEntity);
      emit(eitherToState(failureOrUserCredential, LoginPinState()));
    });
  }

  PinState eitherToState(Either either, PinState state) {
    return either.fold(
      (failure) {
        if (PIN_FAILURE == _mapFailureToMessage(failure)) {
          return ErrorPinState(message: _mapFailureToMessage(failure));
        } else {
          return CreatePinState();
        }
      },
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case PinFailure:
        return PIN_FAILURE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
