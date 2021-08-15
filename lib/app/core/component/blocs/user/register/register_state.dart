part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}

class RegisterException extends RegisterState {
  final String message;

  RegisterException(this.message);
}

class RegisterSuccess extends RegisterState {}
