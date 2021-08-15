import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_shop/app/core/common/size.dart';

import 'package:food_shop/app/core/component/blocs/user/register/register_bloc.dart';
import 'package:food_shop/app/core/component/blocs/user/upload_photo/upload_photo_bloc.dart';

import 'package:food_shop/app/core/component/data/models/request/register_body.dart';
import 'package:food_shop/app/core/component/data/models/request/upload_file_body.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/presentations/screen/navigation/mynavigation.dart';
import 'package:food_shop/app/presentations/widget/appbar/appbar_widget.dart';
import 'package:food_shop/app/presentations/widget/button/button_widget.dart';
import 'package:food_shop/app/presentations/widget/loader/loader_widget.dart';
import 'package:food_shop/app/presentations/widget/textfield/textfield_widget.dart';
import 'package:get/get.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen(
      {Key? key, this.name, this.email, this.password, this.image})
      : super(key: key);

  final String? name;
  final String? email;
  final String? password;
  final File? image;

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final registerBloc = getIt<RegisterBloc>();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final houseController = TextEditingController();
  final cityController = TextEditingController();
  final uploadPhotoBloc = getIt<UploadPhotoBloc>();

  onSignUpPressed() {
    registerBloc.add(OnRegisterEvent(RegisterBody(
        name: widget.name,
        address: addressController.text,
        city: cityController.text,
        email: widget.email,
        houseNumber: houseController.text,
        password: widget.password,
        passwordConfirmation: widget.password,
        phoneNumber: phoneController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => registerBloc),
          BlocProvider(create: (context) => uploadPhotoBloc)
        ],
        child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
          if (state is RegisterFailure) {
            print("FAILURE STATE =>${state.error}");
          } else if (state is RegisterSuccess) {
            if (widget.image != null) {
              uploadPhotoBloc.add(
                  OnUploadPhotoEvent(UploadFileBody(file: widget.image!.path)));
            }

            Future.delayed(Duration(milliseconds: 300))
                .then((value) => Get.off(() => MyNavigation()));
          } else if (state is RegisterException) {
            print(state.message);
          }
        }, builder: (context, state) {
          return BlocListener<UploadPhotoBloc, UploadPhotoState>(
            listener: (context, state) {
              if (state is UploadPhotoFailure) {
                print(state.error);
              } else if (state is UploadPhotoSuccess) {
                print('Photo berhasil diapuoload');
              }
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  SafeArea(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarWidget(
                        title: "Address",
                        subtitle: "Make sure it’s valid",
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Theme.of(context).cardColor,
                          padding: EdgeInsets.only(
                              left: Sizes.defaultMargin,
                              right: Sizes.defaultMargin,
                              top: Sizes.defaultMargin),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFieldWidget(
                                    controller: phoneController,
                                    prefixIcon: Icon(Icons.phone_android),
                                    hintText: "Type your phone number",
                                    labelText: "Phone Number"),
                                TextFieldWidget(
                                    controller: addressController,
                                    prefixIcon: Icon(Icons.add_road),
                                    hintText: "Type your address",
                                    labelText: "Address"),
                                TextFieldWidget(
                                    controller: houseController,
                                    prefixIcon: Icon(Icons.house),
                                    hintText: "Type your house number",
                                    labelText: "House Number"),
                                TextFieldWidget(
                                    controller: cityController,
                                    prefixIcon: Icon(Icons.location_city),
                                    hintText: "Type your city",
                                    labelText: "City"),
                                ButtonWidget(
                                    text: "Sign Up Now",
                                    width: double.infinity,
                                    height: 45,
                                    onPressed: onSignUpPressed),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                  state is RegisterLoading
                      ? LoaderWidget(title: "Loading")
                      : SizedBox.shrink()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
