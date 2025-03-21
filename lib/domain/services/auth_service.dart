import 'package:travel_thinking_app/domain/dto/user_dto.dart';
import 'package:travel_thinking_app/domain/entities/user.dart';
import 'package:travel_thinking_app/domain/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  // 账号注册
  Future<User> register(CreateUserDto user) async {
    bool isAvailable = await _authRepository.isUsernameAvailable(
      user.email ?? user.phone ?? '',
    );
    if (isAvailable) {
      User response = await _authRepository.signIn(user);

      return response;
    }

    throw Exception(
      user.email!.isNotEmpty
          ? '邮箱已经注册, 请换个邮箱'
          : user.phone!.isNotEmpty
          ? '手机已经注册, 请换个手机号码'
          : '',
    );
  }

  // NOTE: 登录
  Future<User> login(UserDto user) async {
    User response = await _authRepository.login(user);

    return response;
  }
}
