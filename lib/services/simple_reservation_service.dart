// services/simple_reservation_service.dart

import 'dart:convert';
import 'package:nuevedejulio/models/simple_reservation_model.dart';
import 'package:nuevedejulio/services/api_service.dart';

class SimpleReservationService {
  static Future<bool> createReservation(SimpleReservation reservation) async {
    try {
      final response = await ApiService.postRequest('simple_reservations/crear', reservation.toJson());
      return response.statusCode == 201;
    } catch (e) {
      print('Error creating reservation: $e');
      return false;
    }
  }

// Otros métodos como getReservations, updateReservation, deleteReservation podrían agregarse aquí
}
