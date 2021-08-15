import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:food_shop/app/core/component/data/models/request/update_profile_body.dart';
import 'package:food_shop/app/core/component/data/models/request/upload_file_body.dart';
import 'package:food_shop/app/core/component/data/models/response/default_model.dart';
import 'package:food_shop/app/core/component/data/models/response/fhoto_profile_model.dart';
import 'package:food_shop/app/core/component/data/models/response/get_profile_model.dart';
import 'package:food_shop/app/core/component/data/models/response/logout_model.dart';
import 'package:food_shop/app/core/constant/api_path/api_path.dart';
import 'package:food_shop/app/core/constant/constants.dart';
import 'package:food_shop/app/core/constant/key_constants.dart';
import 'package:food_shop/app/core/exception/failure.dart';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/login_body.dart';
import '../../models/request/register_body.dart';
import '../../models/response/login_register_model.dart';
import 'user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final storage = GetStorage();

  BaseOptions options = BaseOptions(
      baseUrl: Constant.baseURL,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      headers: {"Content-Type": "application/json"},
      receiveDataWhenStatusError: true);

  @override
  Future<Either<Failure, LoginRegisterModel>> register(
      RegisterBody body) async {
    Dio dio = Dio(options);
    Response response;

    try {
      response = await dio.post(ApiPath.register, data: body.toJson());
      var data = LoginRegisterModel.fromJson(response.data);

      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginRegisterModel>> login(LoginBody body) async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.post(ApiPath.login, data: body.toJson());
      var data = LoginRegisterModel.fromJson(response.data);

      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetProfileModel>> getProfile() async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.get(ApiPath.profile,
          options: Options(headers: {
            "Authorization":
                "${storage.read(KeyConstant.tokenType)} ${storage.read(KeyConstant.accessToken)}"
          }));
      var data = GetProfileModel.fromJson(response.data);
      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FhotoProfileModel>> uploadPhoto(
      UploadFileBody body) async {
    Dio dio = Dio(options);
    Response response;
    try {
      FormData formData =
          FormData.fromMap({'file': await MultipartFile.fromFile(body.file!)});
      response = await dio.post(ApiPath.photo,
          data: formData,
          options: Options(headers: {
            "Authorization":
                "${storage.read(KeyConstant.tokenType)} ${storage.read(KeyConstant.accessToken)}",
            "Content-Type": "multipart/form-data"
          }));
      var data = FhotoProfileModel.fromJson(response.data);
      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DefaultModel>> updateProfile(
      UpdateProfileBody body) async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.post(ApiPath.profile,
          data: body.toJson(),
          options: Options(headers: {
            "Authorization":
                "${storage.read(KeyConstant.tokenType)} ${storage.read(KeyConstant.accessToken)}"
          }));
      var data = DefaultModel.fromJson(response.data);
      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    Dio dio = Dio(options);
    Response response;
    try {
      response = await dio.post(ApiPath.logout,
      
          options: Options(headers: {
            "Authorization":
                "${storage.read(KeyConstant.tokenType)} ${storage.read(KeyConstant.accessToken)}"
          }));
      var data = LogoutModel.fromJson(response.data);
      return right(data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var errorData = e.response!.data['meta']['message'];
        var errorResult = Failure(errorData);

        return left(errorResult);
      }
      return left(Failure("Something error"));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
