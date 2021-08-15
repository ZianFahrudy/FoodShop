import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app_widget.dart';
import 'app/core/injection/injection.dart';
import 'app/core/utill/bloc_observer.dart';


void main() async {
  await GetStorage.init();
  configureDependencies();
  Bloc.observer = MyBlocObserver();

  runApp(AppWidget());
}
