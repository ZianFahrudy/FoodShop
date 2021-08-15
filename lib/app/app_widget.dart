import 'package:flutter/material.dart';
import 'package:food_shop/app/presentations/screen/login/login_screen.dart';
import 'package:food_shop/app/presentations/screen/navigation/mynavigation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/common/theme.dart';

import 'core/constant/key_constants.dart';



class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    bool isLogin = storage.hasData(KeyConstant.accessToken);
    bool isDarkMode = storage.read(KeyConstant.isDarkMode) ?? false;
    return GetMaterialApp(
      theme: AppTheme.basic,
      darkTheme: AppTheme.dark,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: isLogin
          ? MyNavigation(
              index: 0,
            )
          : LoginScreen(),
    );
  }
}
