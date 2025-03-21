import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_thinking_app/application/use_cases/auth_use_case.dart';
import 'package:travel_thinking_app/common/exception/custom_exception.dart';
import 'package:travel_thinking_app/domain/entities/user.dart';
import 'package:travel_thinking_app/domain/value_objects/user_value_object.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());

    try {
      Email email = Email(event.email as String);
      Phone phone = Phone(event.phone as String);
      Password password = Password(event.password);
      User user = await _authUseCase.executeLogin(
        email.value,
        phone.value,
        password.value,
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // 保存用户信息到本地
      prefs.setString('access_token', user.token ?? '');
      prefs.setString('usernames', user.username);
      prefs.setString('avatars', user.avatar ?? '');
      prefs.setString('phones', user.phone ?? '');
      prefs.setString('emails', user.email ?? '');
      prefs.setString('last_login', user.last_login ?? '');
      prefs.setString('signatures', user.signature ?? '');
      prefs.setInt('gender', user.gender);
      prefs.setString('id', user.id);

      emit(LoginSuccess(user: user));
    } on FormatException catch (e) {
      emit(LoginFailure(error: e.message));
    } on LoginFailure catch (e) {
      emit(LoginFailure(error: e.toString()));
    } on BadRequestException catch (e) {
      emit(LoginFailure(error: e.message));
    } on ForbiddenException catch (e) {
      emit(LoginFailure(error: e.message));
    } catch (e) {
      log(e.toString());

      emit(LoginFailure(error: '请求失败, 请重新再试'));
    }
  }
}
