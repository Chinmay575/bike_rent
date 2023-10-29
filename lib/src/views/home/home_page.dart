import 'package:bike_rent/src/domain/models/bike.dart';
import 'package:bike_rent/src/utils/contants.dart';
import 'package:bike_rent/src/views/details/bloc/details_bloc.dart';
import 'package:bike_rent/src/views/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(Initialize());
    super.initState();
  }

  List<String> categories = [
    'Adventure',
    'Crusier',
    'Sportsbike',
    'Tourer',
  ];

  late double deviceWidth, deviceHeight;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => Column(
              children: [
                welcomeUser(),
                showSearchBox(),
                showCategories(),
                popularItems(state.bikes),
                recentlyViewed(state.bikes),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcomeUser() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25, left: 36),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              right: 20,
            ),
            child: Image.asset('assets/images/Ellipse.png'),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Abhi Tiwari',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showSearchBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          filled: true,
          hintText: 'Search Bike',
          fillColor: Colors.grey.shade200,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget showCategories() {
    return Container(
      height: 56,
      width: deviceWidth,
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 56,
                  width: 90,
                  margin: EdgeInsets.only(
                    top: 10,
                    left: (index == 0) ? 10 : 5,
                    right: (index == categories.length - 1) ? 10 : 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: (index == 0) ? Colors.black : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: (index == 0) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget popularItems(List<Bike> bikes) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              'Popular Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: deviceHeight * 0.26,
            width: deviceWidth,
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   width: 10,
                // ),
                Expanded(
                  child: GridView.builder(
                    semanticChildCount: 3,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      // mainAxisSpacing: 10,
                      // mainAxisExtent: deviceWidth,
                      crossAxisSpacing: 10,
                      childAspectRatio: 110 / 85,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: bikes.length - 3,
                    itemBuilder: (context, index) {
                      return item(
                        context,
                        bikes,
                        bikes[index],
                        index,
                      );
                    },
                  ),
                ),
                // const SizedBox(
                //   width: 10,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item(
    BuildContext context,
    List<Bike> bikes,
    Bike bike,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.details);
        BlocProvider.of<DetailsBloc>(context).add(DisplayDetails(bike: bike));
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        margin: EdgeInsets.only(
          left: (index == 0) ? 10 : 5,
          right: (index == bikes.length - 4) ? 10 : 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              bike.image,
              height: 100,
              width: 180,
              fit: BoxFit.fitWidth,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    bike.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    bike.brand,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs.${bike.price}/day',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentlyViewed(List<Bike> bikes) {
    return Container(
      height: 60.00 * bikes.length + 60,
      width: deviceWidth,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recently Viewed',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bikes.length,
              itemBuilder: (context, index) {
                return recentlyViewedItem(
                  context,
                  bikes[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget recentlyViewedItem(BuildContext context, Bike bike) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.details);
        BlocProvider.of<DetailsBloc>(context).add(DisplayDetails(bike: bike));
      },
      child: Container(
        height: 60,
        width: deviceWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    bike.image,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bike.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rs.${bike.price}/day',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            statusStyle(bike.status),
          ],
        ),
      ),
    );
  }

  Widget statusStyle(Status status) {
    if (status.name == Status.available.name) {
      return statusWidget(
        status,
        Colors.black,
        Colors.white,
      );
    } else if (status.name == Status.booked.name) {
      return statusWidget(
        status,
        Colors.grey.shade100,
        Colors.black,
      );
    } else {
      return statusWidget(
        status,
        Colors.grey.shade200,
        Colors.red,
      );
    }
  }

  Widget statusWidget(
    Status status,
    Color backgroundColor,
    Color textColor,
  ) {
    return Container(
      width: 120,
      height: 25,
      // alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          status.name.toUpperCase(),
          style: TextStyle(
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
