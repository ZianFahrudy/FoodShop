import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_shop/app/core/component/data/models/request/update_profile_body.dart';
import 'package:food_shop/app/core/component/data/repository/user/user_repository.dart';

import 'package:injectable/injectable.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

@injectable
class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc(this._repository) : super(UpdateProfileInitial());

  UserRepository _repository;

  @override
  Stream<UpdateProfileState> mapEventToState(
    UpdateProfileEvent event,
  ) async* {
    if (event is OnUpdateProfileEvent) {
      yield UpdateProfileLoading();

      final result = await _repository.updateProfile(event.body);

      yield result.fold(
          (l) => UpdateProfileFailure(l.error!), (r) => UpdateProfileSuccess());
    }
  }
}
