import 'package:car_rent/core/common/data/models/rental_model.dart';
import 'package:car_rent/core/common/data/models/trip_model.dart';
import 'package:car_rent/core/common/domain/usecases/trip.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class TripsRemoteDataSource {
  Future<List<TripModel>> fetchTrips();
  // Future<List<TripModel>> fetchTripsByProfileId(String profileId, bool? host);
  Future<List<TripModel>> fetchTripsByProfileId(
      FetchTripsByProfileIdParams params);

  Future<TripModel> getTripById(int id);
  Future<void> createTrip(TripModel trip);
  Future<TripModel> updateTrip(int id, String status);
  Future<void> deleteTrip(int id);
  Stream<void> listenForTripChanges(String profileId, bool? host);
}

class TripsRemoteDataSourceImpl implements TripsRemoteDataSource {
  final SupabaseClient supabaseClient;

  TripsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<TripModel>> fetchTrips() async {
    try {
      final response = await supabaseClient
          .from('rentals')
          .select('*, vehicle(*), profile(*), host(*)'); // Fetch nested data
      return (response as List<dynamic>)
          .map((rental) => TripModel.fromJson(rental as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<List<TripModel>> fetchTripsByProfileId(
  //     String profileId, bool? host) async {
  //   try {
  //     PostgrestList response;
  //     if (host == true) {
  //       response = await supabaseClient
  //           .from('rentals')
  //           .select('*, vehicle(*), profile(*), host(*)')
  //           .eq('host', profileId)
  //           .order('created_at', ascending: false);
  //       ;
  //     } else {
  //       response = await supabaseClient
  //           .from('rentals')
  //           .select('*, vehicle(*), profile(*), host(*)')
  //           .eq('profile', profileId)
  //           .order('created_at', ascending: false);
  //       ;
  //     }
  //     return (response as List<dynamic>)
  //         .map((rental) => TripModel.fromJson(rental as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     if (e.toString().contains("Failed host lookup")) {
  //       print("Network error: Unable to resolve hostnamehh.");
  //       throw ServerException("Network error: Unable to resolve hostname.");
  //     }
  //     throw ServerException(e.toString());
  //   }
  // }
  @override
  Future<List<TripModel>> fetchTripsByProfileId(
      FetchTripsByProfileIdParams params) async {
    try {
      print("passedstatus: ${params.status}");
      // Build filter parts using PostgREST syntax

      // Build the query—order, limit, and range methods should still be available

      var query;

      if (params.status == null && params.startDate == null) {
        query = supabaseClient
            .from('rentals')
            .select('*, vehicle(*), profile(*), host(*)')
            .eq(params.host == true ? 'host' : 'profile', params.profileId)
            .order('created_at', ascending: false);
      }
      if (params.status != null &&
          params.startDate != null &&
          params.endDate != null) {
        query = supabaseClient
            .from('rentals')
            .select('*, vehicle(*), profile(*), host(*)')
            .eq(params.host == true ? 'host' : 'profile', params.profileId)
            .eq('status', params.status! as Object)
            .gte('start_time', params.startDate!) // Start date filter
            .lte('end_time', params.endDate!) // End date filter
            .order('created_at', ascending: false);
      }

      if (params.status != null && params.startDate == null) {
        query = supabaseClient
            .from('rentals')
            .select('*, vehicle(*), profile(*), host(*)')
            .eq(params.host == true ? 'host' : 'profile', params.profileId)
            .eq('status', params.status! as Object)
            .order('created_at', ascending: false);
      }
      if (params.status == null &&
          params.startDate != null &&
          params.endDate != null) {
        query = supabaseClient
            .from('rentals')
            .select('*, vehicle(*), profile(*), host(*)')
            .eq(params.host == true ? 'host' : 'profile', params.profileId)
            .gte('start_time', params.startDate!) // Start date filter
            .lte('end_time', params.endDate!) // End date filter
            .order('created_at', ascending: false);
      }

      // if (params.limit != null) {
      //   query = query.limit(params.limit!);
      // }

      if (params.offset != null && params.limit != null) {
        query = query.range(params.offset!, params.offset! + params.limit! - 1);
      }
      //.range((page - 1) * limit, (page * limit) - 1);

      final response = await query;
      return (response as List<dynamic>)
          .map((rental) => TripModel.fromJson(rental as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TripModel> getTripById(int id) async {
    try {
      final response = await supabaseClient
          .from('rentals')
          .select('*, vehicle(*), profile(*), host(*)')
          .eq('id', id)
          .single();
      return TripModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createTrip(TripModel trip) async {
    try {
      await supabaseClient.from('rentals').insert(trip.toJson());
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<void> updateTrip(int id, String status) async {
  //   try {
  //     await supabaseClient
  //         .from('rentals')
  //         .update({'status': status}).eq('id', id);
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }
  Future<TripModel> updateTrip(int id, String status) async {
    try {
      final response = await supabaseClient
          .from('rentals')
          .update({'status': status})
          .eq('id', id)
          .select('*, vehicle(*), profile(*), host(*)')
          .single(); // Fetch and return the updated trip
      // print("response trip${response}");
      return TripModel.fromJson(
          response); // Returning the updated trip as a Map
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTrip(int id) async {
    try {
      await supabaseClient.from('rentals').delete().eq('id', id);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<void> listenForTripChanges(String profileId, bool? host) {
    return supabaseClient
        .from('rentals')
        .stream(primaryKey: ['id'])
        .eq(host == true ? 'host' : 'profile', profileId)
        .map((_) => null); // Just trigger an event, no data needed
  }
}
