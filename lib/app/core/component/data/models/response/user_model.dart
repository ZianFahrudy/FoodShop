import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
    explicitToJson: false, createToJson: false, fieldRename: FieldRename.snake)
class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? roles;
  final String? currentTeamId;
  final String? address;
  @JsonKey(name: "houseNumber")
  final String? houseNumber;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  final String? city;
  final int? createdAt;
  final int? updatedAt;
  final String? profilePhotoPath;
  final String? profilePhotoUrl;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.roles,
      this.currentTeamId,
      this.address,
      this.houseNumber,
      this.phoneNumber,
      this.city,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoPath,
      this.profilePhotoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
