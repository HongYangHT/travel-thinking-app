import 'package:travel_thinking_app/domain/dto/user_dto.dart';
import 'package:travel_thinking_app/domain/entities/user.dart';
import 'package:travel_thinking_app/domain/services/auth_service.dart';

class AuthUseCase {
  final AuthService _authService;

  AuthUseCase(this._authService);

  // 应用层执行注册
  Future<User> executeRegister(
    String? email,
    String? phone,
    String password,
    String captcha,
  ) async {
    CreateUserDto user = CreateUserDto(email, phone, password, captcha);
    User response = await _authService.register(user);

    return response;
  }

  //  应用层执行登录
  Future<User> executeLogin(
    String? email,
    String? phone,
    String password,
  ) async {
    UserDto user = UserDto(email, phone, password);

    User response = await _authService.login(user);

    return response;
  }
}
