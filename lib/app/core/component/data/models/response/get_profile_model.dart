import 'package:food_shop/app/core/component/data/models/response/user_model.dart';

import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';

part 'get_profile_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class GetProfileModel {
  final Meta? meta;
  final UserModel? data;

  GetProfileModel({this.meta, this.data});

  factory GetProfileModel.fromJson(Map<String, dynamic> json) =>
      _$GetProfileModelFromJson(json);
}
