import 'package:json_annotation/json_annotation.dart';

part 'update_profile_body.g.dart';

@JsonSerializable(createFactory: false)
class UpdateProfileBody {
  final String? name;
  final String? address;
  final String? houseNumber;
  final String? phoneNumber;
  final String? city;
  UpdateProfileBody(
      {this.name, this.address, this.houseNumber, this.phoneNumber, this.city});

  Map<String, dynamic> toJson() => _$UpdateProfileBodyToJson(this);
}
