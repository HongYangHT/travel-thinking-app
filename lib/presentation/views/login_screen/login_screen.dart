import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_thinking_app/core/di/locator.dart';
import 'package:travel_thinking_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:travel_thinking_app/presentation/views/login_screen/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 通过 GetIt 获取 BLoC 实例
  final authBloc = getIt<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (_) => authBloc,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 130,
                    right: 20,
                    left: 20,
                  ),
                ),
              );
            }

            if (state is LoginLoading) {
              context.loaderOverlay.show();
            }

            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.network(
                          state.user.avatar ?? '',
                          width: 24.0,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        '您好, ${state.user.email ?? state.user.phone ?? ''}, 欢迎回来!',
                      ),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height - 130,
                    right: 20,
                    left: 20,
                  ),
                ),
              );
              context.loaderOverlay.hide();
              // 使用命名路由跳转到主页面
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          child: Login(),
        ),
      ),
    );
  }
}
