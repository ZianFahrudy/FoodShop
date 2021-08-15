part of 'upload_photo_bloc.dart';

abstract class UploadPhotoEvent extends Equatable {
  const UploadPhotoEvent();

  @override
  List<Object> get props => [];
}

class OnUploadPhotoEvent extends UploadPhotoEvent {
  final UploadFileBody body;
  OnUploadPhotoEvent(this.body);
}
