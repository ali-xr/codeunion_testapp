import 'dart:async';

import 'package:codeunion_testapp/core/exceptions/exceptions.dart';
import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/core/utils/either.dart';
import 'package:codeunion_testapp/features/auth/data/datasources/authentication_data_source.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/authentication_status.dart';
import 'package:codeunion_testapp/features/auth/domain/entities/user_entity.dart';
import 'package:codeunion_testapp/features/auth/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource dataSource;

  AuthenticationRepositoryImpl({
    required this.dataSource,
  });

  final StreamController<AuthenticationStatus> _statusController =
      StreamController.broadcast(sync: true);

  @override
  Stream<AuthenticationStatus> statusStream() async* {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await getUserData();
      yield AuthenticationStatus.authenticated;
    } on Exception {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _statusController.stream;
  }

  @override
  Future<Either<Failure, void>> login(
      {required String email, required String password}) async {
    try {
      final result = await dataSource.login(email: email, password: password);
      _statusController.add(AuthenticationStatus.authenticated);
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final result = await dataSource.getUserData();
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> registerNew(
      {required String email,
      required String nickname,
      required String phone,
      required String password}) async {
    try {
      final result = await dataSource.registerNew(
          email: email, nickname: nickname, phone: phone, password: password);
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}
