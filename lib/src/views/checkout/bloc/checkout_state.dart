// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

class CheckoutState {
  Bike b;
  DateTimeRange range;
  int rent;
  int extraRent;
  CheckoutState({
    required this.b,
    required this.range,
    this.rent = 0,
    this.extraRent = 0,
  });

  CheckoutState copyWith({
    Bike? b,
    DateTimeRange? range,
    int? rent,
    int? extraRent,
  }) {
    return CheckoutState(
      b: b ?? this.b,
      range: range ?? this.range,
      rent: rent ?? this.rent,
      extraRent: extraRent ?? this.extraRent,
    );
  }
}
