import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';

part 'logout_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class LogoutModel {
  final Meta? meta;
  final bool? data;

  LogoutModel({this.meta, this.data});

  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutModelFromJson(json);
}
