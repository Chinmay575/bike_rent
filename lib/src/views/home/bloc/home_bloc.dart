import 'package:bike_rent/src/domain/models/bike.dart';
import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(bikes: [])) {
    on<Initialize>(
      (event, emit) {
        List<Bike> bikes = [
          Bike(
            image: 'assets/images/2021-Honda-Rebel-1100 1.png',
            name: 'Rebel 1100',
            brand: 'Honda',
            price: 1199,
          ),
          Bike(
            image: 'assets/images/Indian-Scout-Bobber-2 1.png',
            name: 'Scout Bobber',
            brand: 'Indian',
            price: 1499,
            status: Status.notAvailable,
          ),
          Bike(
            image: 'assets/images/meteor 1.png',
            name: 'Meteore',
            brand: 'Royal Enfield',
            price: 699,
            status: Status.booked,
          ),
          Bike(
            image: 'assets/images/hayabusa.png',
            name: 'Hayabusa',
            brand: 'Suzuki',
            price: 1599,
            status: Status.booked,
          ),
          Bike(
            image: 'assets/images/Ninja.png',
            name: 'Ninja ZX-10r',
            brand: 'Kawasaki',
            price: 1999,
          ),
          Bike(
            image: 'assets/images/classic 350.png',
            name: 'Classic 350',
            brand: 'Royal Enfield',
            price: 1799,
            status: Status.booked,
          ),
        ];
        if (state.bikes.isEmpty) {
          // print('Loaded');
          emit(HomeState(bikes: bikes));
        } else {
          emit(state);
        }
      },
    );
    on<BookBike>(
      (event, emit) async {
        List<Bike> bikes = state.bikes;
        for (int i = 0; i < bikes.length; i++) {
          if (bikes[i].name == event.b.name) {
            bikes[i].status = Status.booked;
          } else {
            continue;
          }
        }
        emit(state.copyWith(bikes: bikes));
      },
    );
  }
}
