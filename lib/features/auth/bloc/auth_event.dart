// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthenticationEvent extends AuthEvent {
  final AuthType authType;
  final String email;
  final String password;
  AuthenticationEvent({
    required this. authType,
    required this.email,
    required this.password,
  });
}
