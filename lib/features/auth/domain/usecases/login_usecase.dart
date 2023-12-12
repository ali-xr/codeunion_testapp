import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/core/usecases/usecase.dart';
import 'package:codeunion_testapp/core/utils/either.dart';
import 'package:codeunion_testapp/features/auth/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase implements UseCase<void, LoginParams> {
  final AuthenticationRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(LoginParams params) async =>
      repository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.password,
    required this.email,
  });

  @override
  List<Object> get props => [email, password];
}
