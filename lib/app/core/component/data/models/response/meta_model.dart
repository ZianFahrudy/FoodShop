import 'package:json_annotation/json_annotation.dart';

part 'meta_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: false)
class Meta {
  final int? code;
  final String? status;
  final String? message;

  Meta({this.code, this.status, this.message});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
