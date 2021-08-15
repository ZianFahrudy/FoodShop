import 'package:flutter/material.dart';
import 'package:food_shop/app/core/common/palette.dart';
import 'package:food_shop/app/core/common/size.dart';

import 'package:food_shop/app/core/component/blocs/user/profile/get_profile_bloc.dart';

import 'package:food_shop/app/core/component/data/models/response/get_profile_model.dart';
import 'package:food_shop/app/core/injection/injection.dart';


class DeliverToCard extends StatefulWidget {
  const DeliverToCard({
    Key? key,
  }) : super(key: key);

  @override
  _DeliverToCardState createState() => _DeliverToCardState();
}

class _DeliverToCardState extends State<DeliverToCard> {
  final profileBloc = getIt<GetProfileBloc>();
  @override
  void initState() {
    profileBloc.fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetProfileModel?>(
        stream: profileBloc.data,
        builder: (context, snapshot) {
          String name = '';
          String phone = '';
          String address = '';
          String house = '';
          String city = '';

          if (snapshot.hasData) {
            name = snapshot.data!.data!.name!;
            phone = snapshot.data!.data!.phoneNumber!;
            address = snapshot.data!.data!.address!;
            house = snapshot.data!.data!.houseNumber!;
            city = snapshot.data!.data!.city!;
          }
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(Sizes.defaultMargin),
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Deliver to:",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Palette.greyColor)),
                    Text(name, style: Theme.of(context).textTheme.bodyText2!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Phone No.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Palette.greyColor)),
                    Text(phone, style: Theme.of(context).textTheme.bodyText2!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Address",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Palette.greyColor)),
                    Text(address,
                        style: Theme.of(context).textTheme.bodyText2!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("House No.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Palette.greyColor)),
                    Text(house, style: Theme.of(context).textTheme.bodyText2!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("City",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Palette.greyColor)),
                    Text(city, style: Theme.of(context).textTheme.bodyText2!),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
