import 'package:bike_rent/src/domain/models/bike.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc()
      : super(
          CheckoutState(
            b: Bike(
              image: '',
              name: '',
              brand: '',
              price: 0,
            ),
            range: DateTimeRange(
              start: DateTime.now(),
              end: DateTime.now(),
            ),
          ),
        ) {
    on<PickDateRange>(
      (event, emit) async {
        DateTimeRange? range = await showDateRangePicker(
          context: event.context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2024),
        );
        emit(state.copyWith(range: range));
      },
    );
    on<GetDetails>(
      (event, emit) {
        emit(state.copyWith(
          range: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
          rent: event.rent,
          extraRent: event.extraRent,
          b: event.b,
        ));
      },
    );
  }
}
