import 'package:car_rent/core/common/entities/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/common/domain/usecases/fetch_vehicle_owner_profile.dart';
import 'package:meta/meta.dart';

part 'vehicle_owner_profile_event.dart';
part 'vehicle_owner_profile_state.dart';

class VehicleOwnerProfileBloc
    extends Bloc<VehicleOwnerProfileEvent, VehicleOwnerProfileState> {
  final FetchVehicleOwnerProfile fetchVehicleOwnerProfile;

  VehicleOwnerProfileBloc({required this.fetchVehicleOwnerProfile})
      : super(VehicleOwnerProfileInitial()) {
    on<FetchVehicleOwnerProfileEvent>(_onFetchVehicleOwnerProfile);
  }

  void _onFetchVehicleOwnerProfile(FetchVehicleOwnerProfileEvent event,
      Emitter<VehicleOwnerProfileState> emit) async {
    emit(VehicleOwnerProfileLoading());
    final res = await fetchVehicleOwnerProfile(event.hostId);
    res.fold(
      (failure) => emit(VehicleOwnerProfileFailure(failure.message)),
      (profile) => emit(VehicleOwnerProfileLoadSuccess(profile)),
    );
  }
}
