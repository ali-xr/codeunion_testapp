import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:codeunion_testapp/core/data/singletons/service_locator.dart';
import 'package:codeunion_testapp/core/data/singletons/storage.dart';
import 'package:codeunion_testapp/core/data/singletons/store_keys.dart';
import 'package:codeunion_testapp/core/usecases/usecase.dart';
import 'package:codeunion_testapp/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/authentication_status.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/user_entity.dart';
import 'package:codeunion_testapp/features/auth/domain/usecases/get_authentication_status_usecase.dart';
import 'package:codeunion_testapp/features/auth/domain/usecases/get_user_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAuthenticationStatusUseCase _statusUseCase =
      GetAuthenticationStatusUseCase(
    repository: serviceLocator<AuthenticationRepositoryImpl>(),
  );
  final GetUserDataUseCase _getUserDataUseCase = GetUserDataUseCase(
    repository: serviceLocator<AuthenticationRepositoryImpl>(),
  );
  late StreamSubscription<AuthenticationStatus> statusSubscription;

  AuthenticationBloc() : super(const AuthenticationState.unauthenticated()) {
    statusSubscription = _statusUseCase.call(NoParams()).listen((event) {
      add(AuthenticationStatusChanged(status: event));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthenticationStatus.authenticated:
          final userData = await _getUserDataUseCase.call(NoParams());
          if (userData.isRight) {
            emit(AuthenticationState.authenticated(userData.right));
          } else {
            await StorageRepository.deleteString(StoreKeys.token);
            emit(const AuthenticationState.unauthenticated());
          }
          break;
        case AuthenticationStatus.unauthenticated:
          await StorageRepository.deleteString(StoreKeys.token);
          await StorageRepository.deleteBool(StoreKeys.isPurchaseRestored);
          emit(
            const AuthenticationState.unauthenticated(),
          );
          break;
      }
    });
  }

  @override
  Future<void> close() {
    statusSubscription.cancel();
    return super.close();
  }
}
