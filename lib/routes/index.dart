// 定义路由表
import 'package:flutter/material.dart';
import 'package:travel_thinking_app/presentation/views/home/home_screen.dart';
import 'package:travel_thinking_app/presentation/views/login_screen/login_screen.dart';

Map<String, WidgetBuilder> generateRoutes(
  GlobalKey<NavigatorState> navigatorKey,
) {
  return {
    '/': (context) => HomeScreen(title: '旅想', navigatorKey: navigatorKey),
    '/login': (context) => LoginScreen(),
  };
  ;
}
