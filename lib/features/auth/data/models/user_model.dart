import 'package:codeunion_testapp/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.nickname,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

class UserConverter implements JsonConverter<UserEntity, Map<String, dynamic>?> {
  const UserConverter();
  @override
  UserEntity fromJson(Map<String, dynamic>? json) => UserModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(UserEntity object) => {};
}
