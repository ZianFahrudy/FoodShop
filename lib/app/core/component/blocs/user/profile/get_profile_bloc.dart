import 'package:food_shop/app/core/component/data/models/response/get_profile_model.dart';
import 'package:food_shop/app/core/component/data/repository/user/user_repository.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetProfileBloc {
  UserRepository _repository;
  GetProfileBloc(this._repository);

  final _profile = BehaviorSubject<GetProfileModel>();

  Function(GetProfileModel) get updateProfileData => _profile.sink.add;
  Stream<GetProfileModel> get data => _profile.stream;

  fetchProfile() async {
    final result = await _repository.getProfile();
    result.fold((error) {
      print("Something error when request get user profile $error");
      return _profile.addError(error.error!);
    }, (value) {
      return updateProfileData(value);
    });
  }

  dispose() {
    _profile.close();
  }
}
