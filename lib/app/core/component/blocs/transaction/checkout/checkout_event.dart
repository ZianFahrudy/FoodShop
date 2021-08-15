part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class OnCheckoutEvent extends CheckoutEvent {
  final CheckoutBody body;
  OnCheckoutEvent(this.body);
}
