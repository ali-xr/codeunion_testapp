import 'package:codeunion_testapp/core/data/singletons/storage.dart';
import 'package:codeunion_testapp/core/data/singletons/store_keys.dart';
import 'package:codeunion_testapp/core/exceptions/exceptions.dart';
import 'package:codeunion_testapp/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationDataSource {
  Future<void> login({required String email, required String password});

  Future<UserModel> getUserData();

  Future<String> registerNew(
      {required String email,
      required String nickname,
      required String phone,
      required String password});
}

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
  final Dio _dio;

  AuthenticationDataSourceImpl(this._dio);

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print('token from response: ${response.data['tokens']['accessToken']}');
        //thisisrlycoolpass
        await StorageRepository.putString(
            StoreKeys.token, response.data['tokens'][StoreKeys.token]);
      } else if (response.statusCode != null &&
          response.statusCode! >= 400 &&
          response.statusCode! < 500) {
        if (response.data is Map) {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: ((response.data as Map).values.isNotEmpty
                      ? (response.data as Map).values.first
                      : 'Ошибка при входе')
                  .toString());
        } else {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: response.data.toString());
        }
      } else {
        throw ServerException(
            statusCode: response.statusCode!,
            errorMessage: response.data.toString());
      }
    } on ServerException {
      rethrow;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      final response = await _dio.get('/user/profile/',
          options: Options(headers: {
            'Authorization':
                'Token ${StorageRepository.getString(StoreKeys.token)}'
          }));
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return UserModel.fromJson(response.data);
      } else {
        await StorageRepository.deleteString(StoreKeys.token);
        if (response.data is Map) {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: ((response.data as Map).values.isNotEmpty
                      ? (response.data as Map).values.first
                      : 'ошибка при получении пользователя')
                  .toString());
        } else {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: response.data.toString());
        }
      }
    } on ServerException {
      rethrow;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<String> registerNew(
      {required String email,
      required String nickname,
      required String phone,
      required String password}) async {
    if (nickname.isNotEmpty) {
      try {
        final response =
            await _dio.post('/auth/registration/customer/new', data: {
          "email": email,
          "nickname": nickname,
          "phone": phone,
          "password": password,
        });
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          return response.data['state_id'] as String;
        } else {
          if (response.data is Map) {
            throw ServerException(
                statusCode: response.statusCode!,
                errorMessage: ((response.data as Map).values.isNotEmpty
                        ? ((response.data as Map).values.first is Map)
                            ? ((response.data as Map).values.first as Map)
                                .values
                                .first
                            : (response.data as Map).values.first
                        : 'Ошибка при регистрации')
                    .toString());
          } else {
            throw ServerException(
                statusCode: response.statusCode!,
                errorMessage: response.data.toString());
          }
        }
      } on ServerException {
        rethrow;
      } on Exception catch (e) {
        throw ParsingException(errorMessage: e.toString());
      }
    } else {
      throw const ParsingException(
          errorMessage: 'Никнейм не может быть пустым');
    }
  }
}
