// //user_service.dart
//
// import 'package:admin_digiticket2024/models/user_model.dart';
// import 'package:admin_digiticket2024/services/api_service.dart';
// import 'dart:convert';
//
// class UserService {
//   static Future<List<User>> getUsers() async {
//     final response = await ApiService.getRequest('usuarios/listar');
//     Iterable jsonResponse = json.decode(response.body);
//     return jsonResponse.map((user) => User.fromJson(user)).toList();
//   }
//
//   static Future<User> createUser(User user) async {
//     final response = await ApiService.postRequest('usuarios/crear', user.toJson());
//     return User.fromJson(json.decode(response.body));
//   }
//
//   static Future<User> updateUser(User user) async {
//     final response = await ApiService.putRequest('usuarios/${user.id}', user.toJson());
//     return User.fromJson(json.decode(response.body));
//   }
//
//   static Future<void> deleteUser(int id) async {
//     await ApiService.deleteRequest('usuarios/$id');
//   }
// }
