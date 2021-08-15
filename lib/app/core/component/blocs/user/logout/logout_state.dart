part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutFailure extends LogoutState {
  final String error;
  LogoutFailure(this.error);
}

class LogoutSuccess extends LogoutState {}
