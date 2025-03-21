import 'package:travel_thinking_app/domain/dto/user_dto.dart';
import 'package:travel_thinking_app/domain/entities/user.dart';

abstract class AuthRepository {
  // 用户名是否可用, 邮箱或者手机号是否已经注册过
  Future<bool> isUsernameAvailable(String username);
  // 登录接口
  Future<User> login(UserDto user);

  // 注册接口
  Future<User> signIn(CreateUserDto user);
}
