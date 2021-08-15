
import 'package:json_annotation/json_annotation.dart';

import 'meta_model.dart';

part 'fhoto_profile_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class FhotoProfileModel {
  final Meta? meta;
  final List<dynamic>? data;

  FhotoProfileModel({this.meta, this.data});

  factory FhotoProfileModel.fromJson(Map<String, dynamic> json) =>
      _$FhotoProfileModelFromJson(json);
}
