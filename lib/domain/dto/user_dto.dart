class UserDto {
  final String? email;
  final String? phone;
  final String password;

  UserDto(this.email, this.phone, this.password);

  Map<String, dynamic> toJson() {
    return {'email': email, 'phone': phone, 'password': password};
  }
}

class CreateUserDto extends UserDto {
  final String captcha;

  CreateUserDto(super.email, super.phone, super.password, this.captcha);

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'captcha': captcha,
    };
  }
}
