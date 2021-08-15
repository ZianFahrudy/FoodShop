import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable(createFactory: false)
class RegisterBody {
  final String? name;
  final String? email;
  final String? password;
  @JsonKey(name: "password_confirmation")
  final String? passwordConfirmation;
  final String? address;
  final String? city;
  final String? houseNumber;
  final String? phoneNumber;

  RegisterBody({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.address,
    this.city,
    this.houseNumber,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}
