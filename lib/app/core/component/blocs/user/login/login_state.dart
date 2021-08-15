part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class LoginException extends LoginState {
  final String message;
  LoginException(this.message);
}

class LoginSuccess extends LoginState {}
