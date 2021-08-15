import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:food_shop/app/core/common/size.dart';

import 'package:food_shop/app/presentations/screen/register/address/address_screen.dart';
import 'package:food_shop/app/presentations/widget/appbar/appbar_widget.dart';
import 'package:food_shop/app/presentations/widget/button/button_widget.dart';
import 'package:food_shop/app/presentations/widget/textfield/textfield_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obsecureText = true;

  @override
  void initState() {
    super.initState();
  }

  File? _image;

  /// get image from camera and gallery
  void _getImage(bool isCamera) async {
    final pickedImage = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 30);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        print(_image);
      }
    });
  }

  isValid() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: Column(children: [
          AppBarWidget(
            subtitle: "Register and eat",
            title: "Sign Up",
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () => _getImage(true),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: _image != null
                                    ? Image.file(
                                        _image!,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(90),
                                            border: Border.all(
                                                color: Palette.greyColor)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          child: Image.network(
                                            'http://nakertrans.sumbarprov.go.id/images/noimage.jpg',
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFieldWidget(
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            prefixIcon: Icon(Icons.people),
                            hintText: "Type your full name",
                            labelText: "Full Name"),
                        TextFieldWidget(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email),
                            hintText: "Type your email address",
                            labelText: "Email Address"),
                        TextFieldWidget(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsecureText = !obsecureText;
                                      });
                                    },
                                    child: Icon(obsecureText
                                        ? IconlyLight.show
                                        : IconlyLight.hide))),
                            hintText: "Type your password",
                            obsecureText: obsecureText,
                            labelText: "Password"),
                        ButtonWidget(
                            text: "Continue",
                            width: double.infinity,
                            height: 45,
                            onPressed: isValid()
                                ? () => Get.to(() => AddressScreen(
                                      image: _image,
                                      email: emailController.text.trim(),
                                      name: nameController.text,
                                      password: passwordController.text.trim(),
                                    ))
                                : (passwordController.text.length <= 8)
                                    ? () {
                                        Get.snackbar("Gagal",
                                            "Password minimal 8 karakter",
                                            backgroundColor: Palette.redColor,
                                            colorText: Colors.white);
                                      }
                                    : () {
                                        Get.snackbar(
                                            "Gagal", "Field tidak boleh kosong",
                                            backgroundColor: Palette.redColor,
                                            colorText: Colors.white);
                                      })
                      ],
                    ),
                  )))
        ])),
      ),
    );
  }
}
