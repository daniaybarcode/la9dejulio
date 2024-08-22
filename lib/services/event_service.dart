// services/event_service.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:nuevedejulio/models/event_model.dart';
import 'package:nuevedejulio/services/api_service.dart';
import 'package:http_parser/http_parser.dart';

class EventService {
  static Future<List<Event>> getEvents() async {
    final response = await ApiService.getRequest('eventos/listar');
    Iterable jsonResponse = json.decode(response.body);
    return jsonResponse.map((event) => Event.fromJson(event)).toList();
  }

  static Future<Event> createEvent(Event event) async {
    final response = await ApiService.postRequest('eventos/crear', event.toJson());
    return Event.fromJson(json.decode(response.body));
  }

  static Future<Event> updateEvent(Event event) async {
    final response = await ApiService.putRequest('eventos/${event.idEvent}/actualizar', event.toJson());
    return Event.fromJson(json.decode(response.body));
  }

  static Future<void> deleteEvent(int id) async {
    await ApiService.deleteRequest('eventos/$id/eliminar');
  }

  static Future<void> uploadEventImage(int id, Uint8List imageBytes, String imageName) async {
    final uri = Uri.parse('${ApiService.baseUrl}/eventos/$id/upload-image');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: imageName,
        contentType: MediaType('image', 'jpeg'), // Cambia esto según el tipo de imagen que uses
      ),
    );
    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to upload image');
    }
  }
}
