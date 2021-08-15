import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:food_shop/app/core/component/data/models/request/register_body.dart';
import 'package:food_shop/app/core/component/data/repository/user/user_repository.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._repository) : super(RegisterInitial());

  UserRepository _repository;

  final storage = GetStorage();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is OnRegisterEvent) {
      RegisterBody registerBody = event.body;

      if (registerBody.name!.isEmpty) {
        yield RegisterException("Nama tidak boleh kosong");
      } else if (registerBody.email!.isEmpty) {
        yield RegisterException("Email tidak boleh kosong");
      } else if (registerBody.password!.isEmpty) {
        yield RegisterException("Password tidak boleh kosong");
      } else if (registerBody.passwordConfirmation != registerBody.password) {
        yield RegisterException("Password tidak cocok");
      } else {
        yield RegisterLoading();

        final result = await _repository.register(event.body);

        yield result.fold((error) {
          print("ERORNYA BOSS =>$error");

          return RegisterFailure(error.error!);
        }, (value) {
          /// Save user [accessToken, tokenType, userID] to [local storage]
          storage.write(KeyConstant.accessToken, value.data!.accessToken);
          storage.write(KeyConstant.tokenType, value.data!.tokenType);
          storage.write(KeyConstant.isLogin, true);
          storage.write(KeyConstant.userId, value.data!.user!.id);
          return RegisterSuccess();
        });
      }
    }
  }
}
