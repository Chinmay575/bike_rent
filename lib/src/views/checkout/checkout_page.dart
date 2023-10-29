import 'package:bike_rent/src/domain/models/bike.dart';
import 'package:bike_rent/src/utils/contants.dart';
import 'package:bike_rent/src/views/checkout/bloc/checkout_bloc.dart';
import 'package:bike_rent/src/views/home/bloc/home_bloc.dart';
import 'package:bike_rent/src/widgets/appbar.dart';
import 'package:bike_rent/src/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late double deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    // print(stat)
    return Scaffold(
      appBar: appBar(context, 'Check Out'),
      body: SingleChildScrollView(
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          // print(state.)
          builder: (context, state) {
            String startDate =
                DateFormat.yMMMMd().format(state.range.start).toString();
            String endDate =
                DateFormat.yMMMMd().format(state.range.end).toString();
            // print(state.b.status);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                dateRange(
                  context,
                  startDate,
                  endDate,
                ),
                applyCoupon(),
                bill(
                  state.range.duration.inDays,
                  state.rent,
                  state.extraRent,
                  0,
                ),
                button(
                  context,
                  'Pay',
                  () {
                    if (state.b.status.name == Status.available.name) {
                      Navigator.pushNamed(context, AppRoutes.home);
                      BlocProvider.of<HomeBloc>(context).add(
                        BookBike(b: state.b),
                      );
                      Fluttertoast.showToast(msg: 'Bike is booked');
                    } else if (state.b.status.name == Status.booked.name) {
                      Navigator.pushNamed(context, AppRoutes.home);
                      Fluttertoast.showToast(msg: 'Bike is already booked');
                    } else {
                      Navigator.pushNamed(context, AppRoutes.home);
                      Fluttertoast.showToast(msg: 'Bike is not available');
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget dateRange(
    BuildContext context,
    String startDate,
    String lastDate,
  ) {
    return Container(
      height: deviceHeight * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          pickedDateWidget('Start Date', startDate),
          pickedDateWidget('End Date', lastDate),
        ],
      ),
    );
  }

  Widget pickedDateWidget(String label, String date) {
    return Container(
      height: deviceHeight * 0.1,
      width: deviceWidth,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          calenderButton(context),
        ],
      ),
    );
  }

  Widget applyCoupon() {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Apply Coupon',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget bill(
    int days,
    int bikeRent,
    int extraItems,
    int discount,
  ) {
    int totalBikeRent = days * bikeRent;
    int totalExtraItemsRent = days * extraItems;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: deviceHeight * 0.4,
      child: Column(
        // mainAxisAlignment: m,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          billItem('Days', days),
          billItem('Rent', totalBikeRent),
          billItem('Additional items', totalExtraItemsRent),
          billItem('Coupons Discount', discount),
          const Divider(),
          billItem(
            'Total Amount',
            totalExtraItemsRent + totalBikeRent - discount,
          )
        ],
      ),
    );
  }

  Widget billItem(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text('$value'),
      ],
    );
  }
}
