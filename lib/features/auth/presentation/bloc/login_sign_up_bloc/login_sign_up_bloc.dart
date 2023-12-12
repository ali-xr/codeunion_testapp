import 'package:bloc/bloc.dart';
import 'package:codeunion_testapp/core/data/singletons/service_locator.dart';
import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:codeunion_testapp/features/auth/domain/usecases/login_usecase.dart';
import 'package:codeunion_testapp/features/auth/domain/usecases/register_new_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'login_sign_up_event.dart';

part 'login_sign_up_state.dart';

class LoginSignUpBloc extends Bloc<LoginSignUpEvent, LoginSignUpState> {
  final LoginUseCase _loginUseCase = LoginUseCase(
    repository: serviceLocator<AuthenticationRepositoryImpl>(),
  );

  final RegisterNewUseCase _registerNewUseCase = RegisterNewUseCase(
    repository: serviceLocator<AuthenticationRepositoryImpl>(),
  );

  LoginSignUpBloc() : super(const LoginSignUpState.empty()) {
    on<Login>((event, emit) async {
      emit(state.copyWith(loginStatus: FormzSubmissionStatus.inProgress));
      final loginResult = await _loginUseCase
          .call(LoginParams(password: event.password, email: event.email));
      if (loginResult.isRight) {
        emit(state.copyWith(loginStatus: FormzSubmissionStatus.success));
      } else {
        if (loginResult.left is DioFailure) {
          event.onError('Network error');
        } else if (loginResult.left is ParsingFailure) {
          event.onError((loginResult.left as ParsingFailure).errorMessage);
        } else if (loginResult.left is ServerFailure) {
          event.onError((loginResult.left as ServerFailure).errorMessage);
        }
        emit(state.copyWith(loginStatus: FormzSubmissionStatus.failure));
      }
    });
    on<RegisterNewUser>((event, emit) async {
      emit(state.copyWith(
          registerNewUserStatus: FormzSubmissionStatus.inProgress));
      final result = await _registerNewUseCase.call(RegisterNewParams(
          email: event.email,
          nickname: event.nickname,
          phone: event.phone,
          password: event.password));
      if (result.isRight) {
        emit(state.copyWith(
            registerNewUserStatus: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        if (result.left is DioFailure) {
          event.onError('Network error');
        } else if (result.left is ParsingFailure) {
          event.onError((result.left as ParsingFailure).errorMessage);
        } else if (result.left is ServerFailure) {
          event.onError((result.left as ServerFailure).errorMessage);
        }
        emit(state.copyWith(
            registerNewUserStatus: FormzSubmissionStatus.failure));
      }
    });
    on<ChangeConfirmationType>((event, emit) {
      emit(state.copyWith(confirmationType: event.type));
    });
  }
}
