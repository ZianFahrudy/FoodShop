import 'package:dartz/dartz.dart';
import 'package:food_shop/app/core/component/data/models/request/login_body.dart';
import 'package:food_shop/app/core/component/data/models/request/register_body.dart';
import 'package:food_shop/app/core/component/data/models/request/update_profile_body.dart';
import 'package:food_shop/app/core/component/data/models/request/upload_file_body.dart';
import 'package:food_shop/app/core/component/data/models/response/default_model.dart';
import 'package:food_shop/app/core/component/data/models/response/fhoto_profile_model.dart';
import 'package:food_shop/app/core/component/data/models/response/get_profile_model.dart';
import 'package:food_shop/app/core/component/data/models/response/login_register_model.dart';
import 'package:food_shop/app/core/component/data/models/response/logout_model.dart';
import 'package:food_shop/app/core/exception/failure.dart';


abstract class UserRepository {
  Future<Either<Failure, LoginRegisterModel>> register(RegisterBody body);
  Future<Either<Failure, LoginRegisterModel>> login(LoginBody body);
  Future<Either<Failure, GetProfileModel>> getProfile();
  Future<Either<Failure, FhotoProfileModel>> uploadPhoto(UploadFileBody body);
  Future<Either<Failure, DefaultModel>> updateProfile(UpdateProfileBody body);
  Future<Either<Failure, LogoutModel>> logout();
}
