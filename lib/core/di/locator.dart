import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:travel_thinking_app/application/use_cases/auth_use_case.dart';
import 'package:travel_thinking_app/common/exception/custom_exception.dart';
import 'package:travel_thinking_app/common/utils/event_bus.dart';
import 'package:travel_thinking_app/domain/services/auth_service.dart';
import 'package:travel_thinking_app/infrastructure/repositories/http_auth_repository.dart';
import 'package:travel_thinking_app/presentation/bloc/auth/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() async {
  // NOTE: 设置dio的配置
  final options = BaseOptions(
    // NOTE: 设置路由baseUri
    baseUrl: 'http://192.166.10.229:3000',
    connectTimeout: Duration(seconds: 2 * 60),
    receiveTimeout: Duration(seconds: 2 * 60),
  );
  final dio = Dio(options);
  final List<String> listOfPaths = [
    '/auth/login',
    '/auth/login-phone',
    '/auth/register',
    '/auth/register-phone',
    '/auth/captcha',
    '/auth/logout',
  ];

  EventBus? eventBus = EventBus.getInstance();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) async {
        if (listOfPaths.contains(options.path.toString())) {
          return handler.next(options);
        }
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('access_token');
        if (token!.isNotEmpty) {
          options.headers.addAll({'Authorization': token});
        }

        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.data);
          if (data['code'] == 200) {
            return handler.next(response);
          }

          throw BadRequestException(data['message']);
        }

        if (response.statusCode == 400) {
          Map<String, dynamic> data = jsonDecode(response.data);
          throw BadRequestException(data['result']['message']);
        }

        if (response.statusCode == 403) {
          // NOTE: 通过EventBus触发事件, 在主页面全局处理
          eventBus!.triggerEvent(EventBusType.forbidden);
          // throw ForbiddenException('请求资源受限, 请联系管理员');
        }

        if (response.statusCode == 401) {
          // NOTE: 通过EventBus触发事件, 在主页面全局处理
          eventBus!.triggerEvent(EventBusType.unAuthorized);
          // throw UnauthorizedException('登录超时, 请重新登录');
        }
        return handler.next(response);
      },
    ),
  );

  // 开发环境打印请求体
  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  );

  // 应用层用例
  getIt.registerLazySingleton<AuthUseCase>(
    () => AuthUseCase(AuthService(HttpAuthRepository(dio))),
  );

  // BLoC 工厂（每次创建新实例）
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthUseCase>()));
}
