part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateProfileEvent extends UpdateProfileEvent {
  final UpdateProfileBody body;
  OnUpdateProfileEvent(this.body);
}
