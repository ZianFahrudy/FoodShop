import 'package:food_shop/app/core/component/data/models/response/user_model.dart';

import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';

part 'login_register_model.g.dart';

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class LoginRegisterModel {
  final Meta? meta;
  final DataLoginRegisterModel? data;

  LoginRegisterModel({this.meta, this.data});

  factory LoginRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRegisterModelFromJson(json);
}

@JsonSerializable(
    createToJson: false, explicitToJson: false, fieldRename: FieldRename.snake)
class DataLoginRegisterModel {
  final String? accessToken;
  final String? tokenType;
  final UserModel? user;

  DataLoginRegisterModel({this.accessToken, this.tokenType, this.user});
  factory DataLoginRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$DataLoginRegisterModelFromJson(json);
}
