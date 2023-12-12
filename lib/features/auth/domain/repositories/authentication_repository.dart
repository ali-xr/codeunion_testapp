import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/core/utils/either.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/authentication_status.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> statusStream();

  Future<Either<Failure, void>> login(
      {required String email, required String password});

  Future<Either<Failure, UserEntity>> getUserData();

  Future<Either<Failure, String>> registerNew({
    required String email,
    required String nickname,
    required String phone,
    required String password,
  });
}
