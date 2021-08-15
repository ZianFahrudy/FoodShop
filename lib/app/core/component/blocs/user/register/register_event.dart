part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnRegisterEvent extends RegisterEvent {
  final RegisterBody body;

  OnRegisterEvent(this.body);
}
