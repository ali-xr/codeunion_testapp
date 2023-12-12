import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String nickname;
  final String email;

  const UserEntity({
    this.id = 0,
    this.nickname = '',
    this.email = '',
  });

  UserEntity copyWith({
    int? id,
    String? nickname,
    String? email,
  }) =>
      UserEntity(
        id: id ?? this.id,
        email: email ?? this.email,
        nickname: nickname ?? this.nickname,
      );

  @override
  List<Object?> get props => [
        id,
        email,
        nickname,
      ];
}
