import 'package:bike_rent/src/domain/models/bike.dart';
import 'package:bike_rent/src/domain/models/equipment.dart';
import 'package:bloc/bloc.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(InitialState()) {
    on<DisplayDetails>((event, emit) {
      emit(LoadingState());
      List<Equipment> items = [
        Equipment(
          name: 'Helmet',
          image: 'assets/images/helm.png',
          price: 800,
        ),
        Equipment(
          name: 'Riding Jackets',
          image: 'assets/images/jacket.png',
          price: 800,
        ),
        Equipment(
          name: 'Riding Gloves',
          image: 'assets/images/Frame 4.png',
          price: 800,
        ),
        Equipment(
          name: 'Riding Boots',
          image: 'assets/images/boots.png',
          price: 800,
        ),
      ];
      emit(LoadedState(
        bike: event.bike,
        eq: items,
      ));
    });
    on<AddRemoveExtraItems>(
      (event, emit) {
        List<Equipment> eq = event.prev.eq ?? [];
        if (event.operation == 'Add') {
          eq[event.index].q++;
        } else {
          if (eq[event.index].q > 0) {
            eq[event.index].q--;
          }
        }
        emit(LoadedState(bike: event.prev.bike, eq: eq));
      },
    );
  }
}
