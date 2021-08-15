import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable(createFactory: false)
class LoginBody {
  final String email;
  final String password;

  LoginBody(this.email, this.password);

  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
