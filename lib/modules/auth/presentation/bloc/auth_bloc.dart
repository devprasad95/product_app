import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/modules/auth/domain/entities/sign_in_entity.dart';

import '../../../../core/constants/constant_values.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/use_cases/auth_state_changes_use_case.dart';
import '../../domain/use_cases/sign_in_use_case.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import '../../domain/use_cases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final AuthStateChangesUseCase authStateChangesUseCase;
  late StreamSubscription<User?> _authSubscription;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.authStateChangesUseCase,
  }) : super(AuthInitial()) {
    _authSubscription = authStateChangesUseCase().listen((user) {
      add(AuthStateChangesEvent(user)); 
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      final failureOrUserCredential = await signUpUseCase(event.signUpEntity);
      emit(eitherToState(failureOrUserCredential, AuthSignedUpState()));
    });

    on<SignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      final failureOrUserCredential = await signInUseCase(event.signInEntity);
      emit(eitherToState(failureOrUserCredential, AuthSignedInState()));
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      final failureOrVoid = await signOutUseCase();
      emit(eitherToState(failureOrVoid, AuthLoggedOutState()));
    });

    on<AuthStateChangesEvent>((event, emit) {
      emit(AuthLoadingState());
      final authStream = authStateChangesUseCase();
      authStream.listen((user) {
        print(user);
        if (user != null) {
          emit(AuthSignedInState());
        } else {
          emit(AuthLoggedOutState());
        }
      });
    });
  }
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  AuthState eitherToState(Either either, AuthState state) {
    return either.fold(
      (failure) {
        if (ALREADY_EXISTING_ACCOUNT_FAILURE == _mapFailureToMessage(failure)) {
          return AuthLoggedOutState();
        } else {
          return AuthErrorState(message: _mapFailureToMessage(failure));
        }
      },
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE;
      case OfflineFailure:
        return OFFLINE_FAILURE;
      case WeekPassWordFailure:
        return WEEK_PASSWORD_FAILURE;
      case AlreadyExistingAccountFailure:
        return ALREADY_EXISTING_ACCOUNT_FAILURE;
      case NoUserFailure:
        return NO_USER_FAILURE;
      case TooManyRequestsFailure:
        return TOO_MANY_REQUESTS_FAILURE;
      case WrongPasswordFailure:
        return WRONG_PASSWORD_FAILURE;
      case UnmatchedPassWordFailure:
        return UNMATCHED_PASSWORD_FAILURE;
      case NotLoggedInFailure:
        return '';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
