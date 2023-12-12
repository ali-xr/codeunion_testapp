import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/core/usecases/usecase.dart';
import 'package:codeunion_testapp/core/utils/either.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/user_entity.dart';
import 'package:codeunion_testapp/features/auth/domain/repositories/authentication_repository.dart';

class GetUserDataUseCase implements UseCase<UserEntity, NoParams> {
  final AuthenticationRepository repository;

  GetUserDataUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) =>
      repository.getUserData();
}
