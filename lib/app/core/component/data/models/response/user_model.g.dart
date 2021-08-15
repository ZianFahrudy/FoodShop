// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    emailVerifiedAt: json['email_verified_at'] as String?,
    roles: json['roles'] as String?,
    currentTeamId: json['current_team_id'] as String?,
    address: json['address'] as String?,
    houseNumber: json['houseNumber'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    city: json['city'] as String?,
    createdAt: json['created_at'] as int?,
    updatedAt: json['updated_at'] as int?,
    profilePhotoPath: json['profile_photo_path'] as String?,
    profilePhotoUrl: json['profile_photo_url'] as String?,
  );
}
