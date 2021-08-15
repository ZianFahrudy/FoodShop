// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../component/blocs/food/food_list_bloc.dart' as _i10;
import '../component/blocs/transaction/checkout/checkout_bloc.dart' as _i9;
import '../component/blocs/transaction/transaction_list/transaction_list_bloc.dart'
    as _i15;
import '../component/blocs/user/login/login_bloc.dart' as _i12;
import '../component/blocs/user/logout/logout_bloc.dart' as _i13;
import '../component/blocs/user/profile/get_profile_bloc.dart' as _i11;
import '../component/blocs/user/profile/update_profile/update_profile_bloc.dart'
    as _i16;
import '../component/blocs/user/register/register_bloc.dart' as _i14;
import '../component/blocs/user/upload_photo/upload_photo_bloc.dart' as _i17;
import '../component/data/repository/food/food_repository.dart' as _i3;
import '../component/data/repository/food/food_repository_impl.dart' as _i4;
import '../component/data/repository/transaction/transaction_repository.dart'
    as _i5;
import '../component/data/repository/transaction/transaction_repository_impl.dart'
    as _i6;
import '../component/data/repository/user/user_repository.dart' as _i7;
import '../component/data/repository/user/user_repository_impl.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.FoodRepository>(() => _i4.FoodRepositoryImpl());
  gh.lazySingleton<_i5.TransactionRepository>(
      () => _i6.TransactionRepositoryImpl());
  gh.lazySingleton<_i7.UserRepository>(() => _i8.UserRepositoryImpl());
  gh.factory<_i9.CheckoutBloc>(
      () => _i9.CheckoutBloc(get<_i5.TransactionRepository>()));
  gh.factory<_i10.FoodListBloc>(
      () => _i10.FoodListBloc(get<_i3.FoodRepository>()));
  gh.factory<_i11.GetProfileBloc>(
      () => _i11.GetProfileBloc(get<_i7.UserRepository>()));
  gh.factory<_i12.LoginBloc>(() => _i12.LoginBloc(get<_i7.UserRepository>()));
  gh.factory<_i13.LogoutBloc>(() => _i13.LogoutBloc(get<_i7.UserRepository>()));
  gh.factory<_i14.RegisterBloc>(
      () => _i14.RegisterBloc(get<_i7.UserRepository>()));
  gh.factory<_i15.TransactionListBloc>(
      () => _i15.TransactionListBloc(get<_i5.TransactionRepository>()));
  gh.factory<_i16.UpdateProfileBloc>(
      () => _i16.UpdateProfileBloc(get<_i7.UserRepository>()));
  gh.factory<_i17.UploadPhotoBloc>(
      () => _i17.UploadPhotoBloc(get<_i7.UserRepository>()));
  return get;
}
