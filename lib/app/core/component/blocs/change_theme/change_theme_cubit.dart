import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';
import 'package:get_storage/get_storage.dart';

class ChangeThemeCubit extends Cubit<ThemeMode> {
  ChangeThemeCubit() : super(ThemeMode.system);

  final storage = GetStorage();

  void changeTheme() {
    bool isDarkMode = storage.read(KeyConstant.isDarkMode);
    if (isDarkMode) {
      emit(ThemeMode.dark);
    } else if (!isDarkMode) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.system);
    }
  }
}
