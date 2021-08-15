import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_shop/app/core/component/data/repository/user/user_repository.dart';

import 'package:injectable/injectable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

@injectable
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc(this._repository) : super(LogoutInitial());

  UserRepository _repository;

  @override
  Stream<LogoutState> mapEventToState(
    LogoutEvent event,
  ) async* {
    if (event is OnLogoutEvent) {
      yield LogoutLoading();

      final result = await _repository.logout();

      yield result.fold((l) => LogoutFailure(l.error!), (r) => LogoutSuccess());
    }
  }
}
