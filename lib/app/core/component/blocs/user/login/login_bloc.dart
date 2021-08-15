import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:food_shop/app/core/component/data/models/request/login_body.dart';
import 'package:food_shop/app/core/component/data/repository/user/user_repository.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repository) : super(LoginInitial());

  UserRepository _repository;

  final storage = GetStorage();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnLoginEvent) {
      LoginBody loginBody = event.body;

      if (loginBody.email.isEmpty) {
        yield LoginException("Email tidak boleh kosong");
      } else if (!(loginBody.email.contains("@"))) {
        yield LoginException("Masukan format email yang benar");
      } else if (loginBody.password.isEmpty) {
        yield LoginException("Password tidak boleh kosong");
      } else {
        yield LoginLoading();

        final result = await _repository.login(event.body);

        yield result.fold((l) => LoginFailure(l.error!), (value) {
          /// Save user [accessToken, tokenType, userID] to [local storage]
          storage.write(KeyConstant.accessToken, value.data!.accessToken);
          storage.write(KeyConstant.tokenType, value.data!.tokenType);
          storage.write(KeyConstant.isLogin, true);
          storage.write(KeyConstant.userId, value.data!.user!.id);

          return LoginSuccess();
        });
      }
    }
  }
}
