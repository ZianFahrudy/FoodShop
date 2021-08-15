// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRegisterModel _$LoginRegisterModelFromJson(Map<String, dynamic> json) {
  return LoginRegisterModel(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    data: json['data'] == null
        ? null
        : DataLoginRegisterModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

DataLoginRegisterModel _$DataLoginRegisterModelFromJson(
    Map<String, dynamic> json) {
  return DataLoginRegisterModel(
    accessToken: json['access_token'] as String?,
    tokenType: json['token_type'] as String?,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}
