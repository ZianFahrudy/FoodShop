import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:food_shop/app/core/common/size.dart';
import 'package:food_shop/app/core/component/blocs/user/login/login_bloc.dart';

import 'package:food_shop/app/core/component/data/models/request/login_body.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/presentations/widget/appbar/appbar_widget.dart';
import 'package:food_shop/app/presentations/widget/button/button_widget.dart';
import 'package:food_shop/app/presentations/widget/loader/loader_widget.dart';
import 'package:food_shop/app/presentations/widget/textfield/textfield_widget.dart';
import 'package:get/get.dart';
import '../navigation/mynavigation.dart';
import '../register/sign_up/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginBloc = getIt<LoginBloc>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  onLoginPressed() {
    loginBloc.add(OnLoginEvent(LoginBody(
      emailController.text.trim(),
      passwordController.text.trim(),
    )));
  }

  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocProvider(
        create: (context) => loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginFailure) {
            Get.snackbar("Oopss", state.error,
                snackPosition: SnackPosition.TOP,
                backgroundColor: Palette.redColor,
                colorText: Colors.white);
          } else if (state is LoginSuccess) {
            Get.off(() => MyNavigation());
          } else if (state is LoginException) {
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }, builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      AppBarWidget(
                        title: "Sign In",
                        subtitle: "Find your best ever meal",
                        isBackIcon: false,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              left: Sizes.defaultMargin,
                              right: Sizes.defaultMargin,
                              top: Sizes.defaultMargin),
                          color: Theme.of(context).cardColor,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldWidget(
                                  controller: emailController,
                                  hintText: "Type yout email address",
                                  labelText: "Email Address",
                                  prefixIcon: Icon(Icons.email),
                                ),
                                TextFieldWidget(
                                  controller: passwordController,
                                  hintText: "Type your password",
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obsecureText = !obsecureText;
                                        });
                                      },
                                      icon: Icon(obsecureText
                                          ? IconlyLight.show
                                          : IconlyLight.hide)),
                                  obsecureText: obsecureText,
                                ),
                                SizedBox(height: 10),
                                ButtonWidget(
                                  onPressed: onLoginPressed,
                                  height: 45,
                                  width: double.infinity,
                                  text: "Sign In",
                                ),
                                SizedBox(height: 10),
                                ButtonWidget(
                                  onPressed: () => Get.to(() => SignUpScreen()),
                                  textColor: Colors.white,
                                  height: 45,
                                  width: double.infinity,
                                  color: Palette.greyColor,
                                  text: "Create New Account",
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                (state is LoginLoading)
                    ? LoaderWidget(
                        title: "Loading",
                        color: Theme.of(context).primaryColor,
                      )
                    : SizedBox.shrink()
              ],
            ),
          );
        }),
      ),
    );
  }
}
