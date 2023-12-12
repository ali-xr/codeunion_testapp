// ignore_for_file: one_member_abstracts

import 'package:codeunion_testapp/core/exceptions/failures.dart';
import 'package:codeunion_testapp/core/utils/either.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
