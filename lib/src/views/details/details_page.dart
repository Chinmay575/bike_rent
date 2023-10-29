import 'package:bike_rent/src/domain/models/equipment.dart';
import 'package:bike_rent/src/utils/contants.dart';
import 'package:bike_rent/src/views/checkout/bloc/checkout_bloc.dart';
import 'package:bike_rent/src/views/details/bloc/details_bloc.dart';
import 'package:bike_rent/src/widgets/appbar.dart';
import 'package:bike_rent/src/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late double deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(context, 'Bike Details'),
      body: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) {
          if (state is CheckoutState) {}
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is LoadedState) {
            int totalItems = 0;
            for (var i in state.eq!) {
              totalItems += i.q;
            }
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.35,
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          Container(
                            width: deviceWidth * 0.42 - 20,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.bike!.brand,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  state.bike!.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                bikeStat(
                                  'Category',
                                  state.bike!.category.name,
                                ),
                                bikeStat(
                                  'Displacement',
                                  '${state.bike!.displacement} cc',
                                ),
                                bikeStat(
                                  'Max Speed',
                                  '${state.bike!.maxSpeed} kmph',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: deviceWidth * 0.58,
                            child: Column(
                              children: [
                                Container(
                                  height: (deviceHeight * 0.3) - 60,
                                  width: deviceWidth * 0.6,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(color: Colors.grey),
                                  ),
                                  child: Image.asset(
                                    state.bike!.image,
                                    height: deviceHeight * 0.3 - 100,
                                    width: deviceWidth * 0.5,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                bikeStat(
                                  'Rent',
                                  'Rs.${state.bike!.price} / day',
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        'Add Items',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70.00 * state.eq!.length,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.eq!.length,
                              itemBuilder: (context, index) {
                                return listItem(
                                  state.eq![index],
                                  index,
                                  state,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    button(
                      context,
                      'Next',
                      () {
                        // print(state.bike!.status);
                        BlocProvider.of<CheckoutBloc>(context).add(
                          GetDetails(
                            b: state.bike!,
                            rent: state.bike!.price,
                            extraRent: totalItems * 800,
                          ),
                        );
                        Navigator.pushNamed(context, AppRoutes.checkOut);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget bikeStat(
    String label,
    String text, {
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    Color labelColor = Colors.grey,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 56,
      width: deviceWidth * 0.4,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(Equipment e, int index, LoadedState state) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.asset(e.image),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rs.${e.price}/day',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 50,
            padding: EdgeInsets.symmetric(
              horizontal: (e.q == 0) ? 10 : 5,
              vertical: 2,
            ),
            // alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: (e.q == 0)
                ? GestureDetector(
                    onTap: () {
                      BlocProvider.of<DetailsBloc>(context).add(
                        AddRemoveExtraItems(
                          prev: state,
                          index: index,
                          operation: 'Add',
                        ),
                      );
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : eqAddRemove(e.q, state, index),
          ),
        ],
      ),
    );
  }

  Widget eqAddRemove(int q, LoadedState state, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<DetailsBloc>(context).add(AddRemoveExtraItems(
              prev: state,
              index: index,
              operation: 'Subtract',
            ));
          },
          child: const Text(
            '-',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Text(
          '$q',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<DetailsBloc>(context).add(AddRemoveExtraItems(
              prev: state,
              index: index,
              operation: 'Add',
            ));
          },
          child: const Text(
            '+',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
