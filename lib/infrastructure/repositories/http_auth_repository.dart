import 'package:dio/dio.dart';
import 'package:travel_thinking_app/domain/dto/user_dto.dart';
import 'package:travel_thinking_app/domain/entities/user.dart';

import 'package:travel_thinking_app/domain/repositories/auth_repository.dart';
import 'package:travel_thinking_app/infrastructure/repositories/http_base.dart';

class HttpAuthRepository implements AuthRepository {
  final BaseHttpUri baseHttpUri = BaseHttpUri();

  final Dio dio;
  HttpAuthRepository(this.dio);

  @override
  Future<bool> isUsernameAvailable(String username) async {
    if (username.isEmpty) return false;

    final Response response = await dio.get('/username/$username');
    // http.Response response = await http.get(
    //   Uri.parse('${baseHttpUri.baseUri}/username/$username'),
    // );
    // if (response.statusCode == 200) {
    //   dynamic data = jsonDecode(response.data);
    //   if (data['code'] == 200) {
    //     return data['data'];
    //   }

    //   return false;
    // }

    // return false;

    dynamic data = response.data;
    return data['data'];
  }

  @override
  Future<User> login(UserDto user) async {
    // http.Response response = await http.post(
    //   Uri.parse('${baseHttpUri.baseUri}/auth/login'),
    //   body: user.toJson(),
    // );
    final Response response = await dio.post(
      '/auth/login',
      data: user.toJson(),
    );

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   Map<String, dynamic> data = response.data;
    //   if (data['code'] == 200) {
    //     return User.fromJson(data['result']);
    //   }

    //   throw BadRequestException(data['message']);
    // }

    // if (response.statusCode == 400) {
    //   Map<String, dynamic> data = jsonDecode(response.data);
    //   throw BadRequestException(data['result']['message']);
    // }

    // if (response.statusCode == 403) {
    //   throw ForbiddenException('请求资源受限, 请联系管理员');
    // }

    // if (response.statusCode == 401) {
    //   throw UnauthorizedException('登录超时请重新登录');
    // }

    // throw BadRequestException('登录失败, 请重新登录');

    Map<String, dynamic> data = response.data;

    return User.fromJson(data['result']);
  }

  @override
  Future<User> signIn(CreateUserDto user) async {
    final Response response = await dio.post(
      '/auth/register',
      data: user.toJson(),
    );
    // http.Response response = await http.post(
    //   Uri.parse('${baseHttpUri.baseUri}/auth/register'),
    //   headers: {},
    //   body: jsonEncode(user.toJson()),
    // );

    // if (response.statusCode == 200) {
    //   // Map<String, dynamic> data = jsonDecode(response.data);
    //   Map<String, dynamic> data = response.data;
    //   if (data['code'] == 200) {
    //     return User.fromJson(data['data']);
    //   }

    //   throw Exception(data['message']);
    // }

    // throw Exception('注册失败, 请重新点击注册');

    Map<String, dynamic> data = response.data;

    return User.fromJson(data['data']);
  }
}
