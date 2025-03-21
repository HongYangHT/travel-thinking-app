import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_thinking_app/presentation/bloc/auth/auth_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  // 是否显示密码
  bool _showPassword = false;
  // 判断是否为空
  bool _unameNotEmpty = false;
  // 密码是否为空
  bool _pwdNotEmpty = false;
  // // 验证码是否为空
  // bool _codeNotEmpty = false;
  // // 是否正在发送验证码
  // bool _isSending = false;
  // 是否同意隐私策略
  int _checkedTitle = 1;
  // 是否手机登录
  bool _isLoginByPhone = false;

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _unameController.dispose();
    _pwdController.dispose();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log(state.toString());
        return Container(
          color: Color.fromRGBO(108, 217, 179, 1.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.scaleDown, // 缩放以适应容器
                      alignment: Alignment.center, // 图片对齐方式
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // NOTE: 登录表单
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 24.0)),
                              TextFormField(
                                controller: _unameController,
                                keyboardType:
                                    _isLoginByPhone
                                        ? TextInputType.phone
                                        : TextInputType.emailAddress,
                                style: TextStyle(fontSize: 22.0),
                                decoration: InputDecoration(
                                  labelText: _isLoginByPhone ? '手机号' : '邮箱',
                                  hintText:
                                      _isLoginByPhone
                                          ? '请输入您的手机号码'
                                          : '请输入您的邮箱地址',
                                  prefixIcon: Icon(
                                    _isLoginByPhone
                                        ? Icons.mobile_friendly
                                        : CupertinoIcons.mail,
                                    size: 22.0,
                                  ),
                                  labelStyle: TextStyle(fontSize: 22.0),
                                  hintStyle: TextStyle(fontSize: 22.0),
                                  suffixIcon:
                                      _unameNotEmpty
                                          ? IconButton(
                                            onPressed: () {
                                              _unameController.clear();
                                              setState(() {
                                                _unameNotEmpty = false;
                                              });
                                            },
                                            icon: Icon(
                                              CupertinoIcons.clear_circled,
                                            ),
                                          )
                                          : null,
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    _unameNotEmpty = text.trim().isNotEmpty;
                                  });
                                },
                              ),
                              Padding(padding: EdgeInsets.only(top: 24.0)),
                              TextFormField(
                                style: TextStyle(fontSize: 22.0),
                                controller: _pwdController,
                                decoration: InputDecoration(
                                  labelText: '密码',
                                  hintText: '请输入您的密码',
                                  labelStyle: TextStyle(fontSize: 22.0),
                                  hintStyle: TextStyle(fontSize: 22.0),
                                  prefixIcon: Icon(
                                    CupertinoIcons.lock,
                                    size: 22.0,
                                  ),
                                  suffix: SizedBox(
                                    width: 100.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            _showPassword
                                                ? CupertinoIcons.eye
                                                : CupertinoIcons.eye_slash,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _showPassword = !_showPassword;
                                            });
                                          },
                                        ),
                                        _pwdNotEmpty
                                            ? IconButton(
                                              onPressed: () {
                                                _pwdController.clear();
                                                setState(() {
                                                  _pwdNotEmpty = false;
                                                });
                                              },
                                              icon: Icon(
                                                CupertinoIcons.clear_circled,
                                              ),
                                            )
                                            : Container(height: 0.0),
                                      ],
                                    ),
                                  ),
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    _pwdNotEmpty = text.trim().isNotEmpty;
                                  });
                                },
                                obscureText: !_showPassword,
                              ),
                              // Padding(padding: EdgeInsets.only(top: 24.0)),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       flex: 2,
                              //       child: TextFormField(
                              //         maxLength: 6,
                              //         controller: _codeController,
                              //         decoration: InputDecoration(
                              //           labelText: '验证码',
                              //           hintText: '请输入收到的验证码',
                              //           labelStyle: TextStyle(fontSize: 20.0),
                              //           hintStyle: TextStyle(fontSize: 20.0),
                              //           prefixIcon: Icon(
                              //             CupertinoIcons.t_bubble,
                              //             size: 22.0,
                              //           ),
                              //           suffixIcon:
                              //               _codeNotEmpty
                              //                   ? IconButton(
                              //                     onPressed: () {
                              //                       _codeController.clear();
                              //                       setState(() {
                              //                         _codeNotEmpty = false;
                              //                       });
                              //                     },
                              //                     icon: Icon(
                              //                       CupertinoIcons.clear_circled,
                              //                     ),
                              //                   )
                              //                   : null,
                              //         ),
                              //         onChanged: (text) {
                              //           setState(() {
                              //             _codeNotEmpty = text.trim().isNotEmpty;
                              //           });
                              //         },
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.end,
                              //         children: [
                              //           TextButton(
                              //             style: TextButton.styleFrom(
                              //               foregroundColor:
                              //                   Theme.of(context).primaryColor,
                              //               textStyle: TextStyle(fontSize: 20.0),
                              //             ),
                              //             child: Text('发送验证码'),
                              //             onPressed: () {},
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Padding(padding: EdgeInsets.only(top: 72.0)),
                              ConstrainedBox(
                                constraints: BoxConstraints.expand(
                                  height: 55.0,
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Color.fromRGBO(42, 63, 110, 1),
                                        ),
                                    foregroundColor:
                                        WidgetStateProperty.all<Color>(
                                          Colors.white,
                                        ),
                                    textStyle:
                                        WidgetStateProperty.all<TextStyle>(
                                          TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                      LoginButtonPressed(
                                        _unameController.text,
                                        _unameController.text,
                                        password: _pwdController.text,
                                      ),
                                    );
                                  },
                                  child: Text('登 录'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(padding: EdgeInsets.only(top: 24.0)),
                      // NOTE: 提供注册和修改密码接口
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor,
                              textStyle: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 15.0,
                              ),
                            ),
                            onPressed: () {},
                            child: Text('忘记密码?'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(letterSpacing: 1.0),
                                children: [
                                  TextSpan(
                                    text: '没有账号?去',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(text: ' '),
                                  TextSpan(
                                    text: '注册',
                                    style: TextStyle(
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(255, 167, 38, .85),
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            // Handle the tap
                                            // print('Text clicked');
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // NOTE: 其他方式登录
                      Expanded(child: Container()),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 24.0,
                                  ),
                                  child: Text('其他登录方式'),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 24.0,
                                  horizontal: 0,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLoginByPhone = !_isLoginByPhone;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _isLoginByPhone
                                            ? CupertinoIcons.mail
                                            : Icons.mobile_friendly_rounded,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        _isLoginByPhone ? '邮箱账号登录' : '本机号码登录',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // NOTE: 隐私策略
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _checkedTitle,
                                    onChanged: (value) {
                                      setState(() {
                                        _checkedTitle = value ?? 0;
                                      });
                                    },
                                    toggleable: true,
                                  ),
                                  Text.rich(
                                    style: TextStyle(fontSize: 14.0),
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '我已阅读并同意',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        TextSpan(text: ' '),
                                        TextSpan(
                                          text: '旅想服务协议',
                                          style: TextStyle(
                                            letterSpacing: 2.0,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Handle the tap
                                                  // print('Text clicked');
                                                },
                                        ),
                                        TextSpan(text: ' '),
                                        TextSpan(
                                          text: '隐私权政策',
                                          style: TextStyle(
                                            letterSpacing: 2.0,
                                            fontWeight: FontWeight.normal,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          recognizer:
                                              TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Handle the tap
                                                  // print('Text clicked');
                                                },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(left: 0, bottom: 40.0, child: Text('bottom')),
            ],
          ),
        );
      },
    );
  }
}
