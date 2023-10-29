// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class PickDateRange extends CheckoutEvent {
  BuildContext context;
  PickDateRange({
    required this.context,
  });
}

class GetDetails extends CheckoutEvent {
  Bike b;
  int rent;
  int extraRent; 
  GetDetails({
    required this.b,
    required this.rent,
    required this.extraRent,
  });
}
