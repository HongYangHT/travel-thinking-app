import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:travel_thinking_app/core/di/locator.dart';
import 'package:travel_thinking_app/presentation/views/login_screen/login_screen.dart';
import 'package:travel_thinking_app/routes/index.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = generateRoutes(navigatorKey);

    return GlobalLoaderOverlay(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      overlayColor: Colors.grey.withAlpha(204), // 设置为半透明灰色
      overlayWidgetBuilder: (context) {
        return Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: Colors.white,
            size: 100.0,
          ),
        );
      },
      child: MaterialApp(
        title: '旅想',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primaryColor: Color.fromRGBO(42, 63, 110, 1),
        ),
        // home 和 initialRoute 不需要同时存在
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: routes,
        onGenerateRoute: (settings) {
          // 获取路由名称
          final String? routeName = settings.name;

          // 根据路由名称进行权限检查
          switch (routeName) {
            case '/admin':
              // 检查用户是否是管理员
              bool isAdmin = checkAdminPermission();
              if (!isAdmin) {
                // 如果没有权限，跳转到登录页面或其他提示页面
                return MaterialPageRoute(builder: (context) => LoginScreen());
              }
              break;
            default:
              break;
          }

          // 如果权限检查通过，返回对应的页面
          return MaterialPageRoute(
            builder: (context) => routes[routeName]!(context),
          );
        },
      ),
    );
  }

  // 模拟检查管理员权限的函数
  bool checkAdminPermission() {
    // 这里可以替换为实际的权限检查逻辑, tUserInfo() 是获取用户信息的函数
    return false; // 假设当前用户不是管理员
  }
}
