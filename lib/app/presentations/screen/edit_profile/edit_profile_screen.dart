import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_shop/app/core/common/palette.dart';

import 'package:food_shop/app/core/component/blocs/user/profile/get_profile_bloc.dart';
import 'package:food_shop/app/core/component/blocs/user/profile/update_profile/update_profile_bloc.dart';
import 'package:food_shop/app/core/component/blocs/user/upload_photo/upload_photo_bloc.dart';

import 'package:food_shop/app/core/component/data/models/request/update_profile_body.dart';
import 'package:food_shop/app/core/component/data/models/request/upload_file_body.dart';
import 'package:food_shop/app/core/component/data/models/response/user_model.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/presentations/screen/navigation/mynavigation.dart';
import 'package:food_shop/app/presentations/widget/loader/loader_widget.dart';
import 'package:food_shop/app/presentations/widget/textfield/textfield_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileBloc = getIt<UpdateProfileBloc>();
  final uploadPhotoBloc = getIt<UploadPhotoBloc>();
  final getProfileBloc = getIt<GetProfileBloc>();

  late UserModel user;

  @override
  void initState() {
    user = Get.arguments;
    nameController = TextEditingController(text: user.name);
    addressController = TextEditingController(text: user.address);
    houseNumberController = TextEditingController(text: user.houseNumber);
    phoneNumberController = TextEditingController(text: user.phoneNumber);
    cityController = TextEditingController(text: user.city);

    super.initState();
  }

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController houseNumberController;
  late TextEditingController phoneNumberController;
  late TextEditingController cityController;

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
        Get.back();
      }
    });
  }

  onUpdateProfile() {
    profileBloc.add(OnUpdateProfileEvent(UpdateProfileBody(
        address: addressController.text,
        houseNumber: houseNumberController.text,
        name: nameController.text,
        city: cityController.text,
        phoneNumber: phoneNumberController.text)));

    if (_image != null) {
      uploadPhotoBloc
          .add(OnUploadPhotoEvent(UploadFileBody(file: _image!.path)));
    }
  }

  showImageDialog() {
    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _getImage(true),
                child: Text("Camera",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _getImage(false),
                child: Text("Gallery",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Palette.greenColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => profileBloc),
            BlocProvider(create: (context) => uploadPhotoBloc),
          ],
          child: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
              listener: (context, state) {
            if (state is UpdateProfileFailure) {
              Get.snackbar("Oopss", state.error,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Palette.redColor,
                  colorText: Colors.white);
            } else if (state is UpdateProfileSuccess) {
              Get.snackbar("Success", "Profile Updated",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Palette.greenColor,
                  colorText: Colors.white);
              Future.delayed(Duration(seconds: 3)).then((value) {
                Get.to(() => MyNavigation(index: 2));
                getProfileBloc.fetchProfile();
              });
            }
          }, builder: (context, state) {
            return SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          color: Theme.of(context).cardColor,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () => Get.back(),
                                          child: Icon(IconlyLight.arrowLeft2)),
                                      GestureDetector(
                                        onTap: onUpdateProfile,
                                        child: Text(
                                          "Update account",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Palette.redColor,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ]),
                              ),
                              Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  child: Stack(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(top: 30),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Palette.greyColor
                                                .withOpacity(.13),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Palette.greyColor)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: _image != null
                                              ? Image.file(
                                                  _image!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  user.profilePhotoUrl!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: showImageDialog,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 60,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              TextFieldWidget(
                                  controller: nameController,
                                  hintText: "Type your name",
                                  labelText: "Name"),
                              TextFieldWidget(
                                  controller: addressController,
                                  hintText: "Type your address",
                                  labelText: "Address"),
                              TextFieldWidget(
                                  controller: houseNumberController,
                                  hintText: "Type your house number",
                                  labelText: "House Number"),
                              TextFieldWidget(
                                  controller: phoneNumberController,
                                  hintText: "Type your phone number",
                                  labelText: "Phone NUmber"),
                              TextFieldWidget(
                                  controller: cityController,
                                  hintText: "Type your city",
                                  labelText: "City")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  state is UpdateProfileLoading
                      ? LoaderWidget(title: "Loading")
                      : SizedBox.shrink()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
