part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutFailure extends CheckoutState {
  final String error;

  CheckoutFailure(this.error);
}

class CheckoutSuccess extends CheckoutState {
  final TransactionModel transaction;

  CheckoutSuccess(this.transaction);
}
