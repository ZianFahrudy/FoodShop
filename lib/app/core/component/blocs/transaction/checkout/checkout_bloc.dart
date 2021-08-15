import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_shop/app/core/component/data/models/request/checkout_body.dart';
import 'package:food_shop/app/core/component/data/models/response/transaction_model.dart';
import 'package:food_shop/app/core/component/data/repository/transaction/transaction_repository.dart';
import 'package:injectable/injectable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

@injectable
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc(this._repository) : super(CheckoutInitial());

  TransactionRepository _repository;

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if (event is OnCheckoutEvent) {
      yield CheckoutLoading();

      final result = await _repository.checkout(event.body);

      yield result.fold(
          (l) => CheckoutFailure(l.error!), (r) => CheckoutSuccess(r));
    }
  }
}
