import 'package:json_annotation/json_annotation.dart';

part 'upload_file_body.g.dart';

@JsonSerializable(createFactory: false)
class UploadFileBody {
  final String? file;
  UploadFileBody({this.file});

  Map<String, dynamic> toJson() => _$UploadFileBodyToJson(this);
}
