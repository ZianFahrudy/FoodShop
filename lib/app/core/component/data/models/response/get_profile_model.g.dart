// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileModel _$GetProfileModelFromJson(Map<String, dynamic> json) {
  return GetProfileModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : UserModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}
