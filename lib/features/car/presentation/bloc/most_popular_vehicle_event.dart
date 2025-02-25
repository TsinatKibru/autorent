part of 'most_popular_vehicle_bloc.dart';

@immutable
abstract class MostPopularVehicleEvent {}

class FetchMostPopularVehiclesEvent extends MostPopularVehicleEvent {
  final int page;
  final int limit;

  FetchMostPopularVehiclesEvent({required this.page, this.limit = 10});
}
