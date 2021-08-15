import 'package:flutter/material.dart';
import 'package:food_shop/app/core/component/blocs/user/profile/get_profile_bloc.dart';

import 'package:food_shop/app/core/component/data/models/response/get_profile_model.dart';
import 'package:food_shop/app/core/injection/injection.dart';

import 'package:food_shop/app/presentations/widget/image_viewer/image_viewer.dart';
import 'package:get/get.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  _HeaderHomeState createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  final profileBloc = getIt<GetProfileBloc>();

  @override
  void initState() {
    profileBloc.fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: Get.height * 0.13,
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FoodShop",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Let’s get some foods",
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
          ),
          StreamBuilder<GetProfileModel>(
              stream: profileBloc.data,
              builder: (context, snapshot) {
                String imageUrl = '';
                if (snapshot.hasData) {
                  imageUrl = snapshot.data!.data!.profilePhotoUrl!;
                  return GestureDetector(
                    onTap: () => Get.to(() => ImageViewer(imageUrl: imageUrl)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(
                        imageUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }

                return CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}
