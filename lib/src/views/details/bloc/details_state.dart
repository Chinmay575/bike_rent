// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_bloc.dart';

class DetailsState {}

class InitialState extends DetailsState {}

class LoadingState extends DetailsState {}

class LoadedState extends DetailsState {
  Bike? bike;
  List<Equipment>? eq;
  LoadedState({
    this.bike,
    this.eq,
  });

  LoadedState copyWith({
    Bike? bike,
    List<Equipment>? eq,
  }) {
    return LoadedState(
      bike: bike ?? this.bike,
      eq: eq ?? this.eq,
    );
  }
}
