import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_shop/app/core/component/data/models/request/upload_file_body.dart';
import 'package:food_shop/app/core/component/data/repository/user/user_repository.dart';


import 'package:injectable/injectable.dart';

part 'upload_photo_event.dart';
part 'upload_photo_state.dart';

@injectable
class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  UploadPhotoBloc(this._repository) : super(UploadPhotoInitial());

  UserRepository _repository;

  @override
  Stream<UploadPhotoState> mapEventToState(
    UploadPhotoEvent event,
  ) async* {
    if (event is OnUploadPhotoEvent) {
      yield UploadPhotoLoading();

      final result = await _repository.uploadPhoto(event.body);

      yield result.fold(
          (l) => UploadPhotoFailure(l.error!), (r) => UploadPhotoSuccess());
    }
  }
}
