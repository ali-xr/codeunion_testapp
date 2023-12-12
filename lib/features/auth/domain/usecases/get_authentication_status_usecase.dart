import 'package:codeunion_testapp/core/usecases/usecase.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/authentication_status.dart';
import 'package:codeunion_testapp/features/auth/domain/repositories/authentication_repository.dart';

class GetAuthenticationStatusUseCase
    implements StreamUseCase<AuthenticationStatus, NoParams> {
  final AuthenticationRepository repository;

  GetAuthenticationStatusUseCase({required this.repository});

  @override
  Stream<AuthenticationStatus> call(NoParams params) =>
      repository.statusStream();
}
