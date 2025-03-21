part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure({required this.error});
}
