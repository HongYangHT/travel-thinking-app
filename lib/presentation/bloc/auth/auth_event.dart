part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String? email;
  final String? phone;
  final String password;

  LoginButtonPressed(this.email, this.phone, {required this.password});
}
