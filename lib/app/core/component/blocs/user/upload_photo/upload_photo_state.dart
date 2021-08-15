part of 'upload_photo_bloc.dart';

abstract class UploadPhotoState extends Equatable {
  const UploadPhotoState();

  @override
  List<Object> get props => [];
}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoFailure extends UploadPhotoState {
  final String error;
  UploadPhotoFailure(this.error);
}

class UploadPhotoSuccess extends UploadPhotoState {}
