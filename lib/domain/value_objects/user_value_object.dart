class Email {
  final String value;
  Email(this.value) {
    if (value.isNotEmpty &&
        !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      throw FormatException('邮箱格式不正确, 请重新输入');
    }
  }
}

class Phone {
  final String value;

  Phone(this.value) {
    if (!value.isNotEmpty &&
        RegExp(
          r"^1(3\d|4[5-9]|5[0-35-9]|6[2567]|7[0-8]|8\d|9[0-35-9])\d{8}$",
        ).hasMatch(value)) {
      throw FormatException('手机号码格式不正确, 请重新输入');
    }
  }
}

class Password {
  final String value;

  Password(this.value) {
    if (value.length < 6) {
      throw FormatException('密码长度不少于6个字符');
    }
  }
}

class Captcha {
  final String value;
  Captcha(this.value) {
    if (value.length != 4) {
      throw FormatException('请输入正确的验证码');
    }
  }
}
