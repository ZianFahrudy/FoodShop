import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_shop/app/core/common/palette.dart';

import 'package:food_shop/app/core/component/blocs/user/logout/logout_bloc.dart';
import 'package:food_shop/app/core/component/blocs/user/profile/get_profile_bloc.dart';

import 'package:food_shop/app/core/component/data/models/response/get_profile_model.dart';
import 'package:food_shop/app/core/component/data/models/response/user_model.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';
import 'package:food_shop/app/core/injection/injection.dart';
import 'package:food_shop/app/presentations/screen/login/login_screen.dart';
import 'package:food_shop/app/presentations/widget/loader/loader_page.dart';
import 'package:get_storage/get_storage.dart';
import '../edit_profile/edit_profile_screen.dart';
import 'package:get/get.dart';

enum ThemeBrightness { Light, Dark }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileBloc = getIt<GetProfileBloc>();
  final logoutBloc = getIt<LogoutBloc>();

  final storage = GetStorage();

  ThemeBrightness theme = ThemeBrightness.Light;

  @override
  void initState() {
    profileBloc.fetchProfile();
    setState(() {
      theme = Get.isDarkMode ? ThemeBrightness.Dark : ThemeBrightness.Light;
    });
    super.initState();
  }

  onLogout() {
    storage.remove(KeyConstant.tokenType);
    storage.remove(KeyConstant.accessToken);
    storage.remove(KeyConstant.userId);
    storage.remove(KeyConstant.isLogin);

    Get.off(() => LoginScreen());
  }

  void onSaveTheme() {
    Get.back();
    if (theme == ThemeBrightness.Light) {
      Get.changeThemeMode(ThemeMode.light);
      storage.write(KeyConstant.isDarkMode, false);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      storage.write(KeyConstant.isDarkMode, true);
    }
  }

  onChangeTheme(bool value) {
    isDarkmode = value;
    setState(() {
      if (isDarkmode) {
        Get.changeThemeMode(ThemeMode.dark);
        storage.write(KeyConstant.isDarkMode, true);
      } else {
        Get.changeThemeMode(ThemeMode.light);
        storage.write(KeyConstant.isDarkMode, false);
      }
    });
  }

  logoutDialog() {
    Get.dialog(
        AlertDialog(
          title: Text("Do you want exit?"),
          actions: [
            TextButton(onPressed: onLogout, child: Text("Ok")),
            TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
          ],
        ),
        name: "Dialog");
  }

  bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetProfileModel>(
        stream: profileBloc.data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data;
            return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: SafeArea(
                child: Column(
                  children: [
                    buildHeader(context, data!),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        width: double.infinity,
                        child: Text("PREFERENCES")),
                    buildPreferences(context),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        width: double.infinity,
                        child: Text("ACCOUNT")),
                    buildAccount(context)
                  ],
                ),
              ),
            );
          }
          return LoadingPage();
        });
  }

  Container buildAccount(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Row(children: [
                Icon(Icons.security),
                SizedBox(width: 20),
                Text("Security",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 16)),
              ]),
            ),
            Icon(IconlyLight.arrowRight2)
          ]),
          SizedBox(height: 20),
          GestureDetector(
            onTap: logoutDialog,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(children: [
                      Icon(Icons.logout),
                      SizedBox(width: 20),
                      Text("Logout",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 16)),
                    ]),
                  ),
                  Icon(IconlyLight.arrowRight2)
                ]),
          )
        ],
      ),
    );
  }

  Container buildPreferences(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Row(children: [
                Icon(Icons.language),
                SizedBox(width: 20),
                Text("Languages",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 16)),
              ]),
            ),
            Icon(IconlyLight.arrowRight2)
          ]),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Row(children: [
                Icon(Icons.dark_mode),
                SizedBox(width: 20),
                Text("Dark Mode",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 16)),
              ]),
            ),
            Switch(
              value: isDarkmode,
              onChanged: (value) => onChangeTheme(value),
            ),
            // Icon(IconlyLight.arrowRight2),
          ]),
        ],
      ),
    );
  }

  Container buildHeader(BuildContext context, UserModel data) {
    return Container(
      height: Get.height * 0.4,
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Palette.greyColor)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  data.profilePhotoUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(data.name!,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(data.email!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Palette.greyColor)),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Get.isDarkMode ? Colors.amber : Palette.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(130, 45)),
            onPressed: () => Get.to(() => EditProfileScreen(), arguments: data),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Edit Profile",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold)),
                Icon(IconlyLight.arrowRight2)
              ],
            ),
          )
        ],
      ),
    );
  }
}
