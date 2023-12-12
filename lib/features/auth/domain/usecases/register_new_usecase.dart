import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/core/usecases/usecase.dart';
import 'package:codeunion_testapp/core/utils/either.dart';
import 'package:codeunion_testapp/features/auth/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterNewUseCase implements UseCase<String, RegisterNewParams> {
  final AuthenticationRepository repository;

  RegisterNewUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(RegisterNewParams params) async =>
      await repository.registerNew(
          email: params.email,
          nickname: params.nickname,
          phone: params.phone,
          password: params.password);
}

class RegisterNewParams extends Equatable {
  final String email;
  final String nickname;
  final String phone;
  final String password;

  const RegisterNewParams(
      {required this.email,
      required this.nickname,
      required this.phone,
      required this.password});

  @override
  List<Object?> get props => [email, nickname, phone, password];
}
