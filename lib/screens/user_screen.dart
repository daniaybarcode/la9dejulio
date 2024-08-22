// //user_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:admin_digiticket2024/models/user_model.dart';
// import 'package:admin_digiticket2024/services/user_service.dart';
// import 'package:admin_digiticket2024/widgets/custom_button.dart';
// import 'package:admin_digiticket2024/widgets/custom_text_field.dart';
// import 'package:admin_digiticket2024/widgets/loading_indicator.dart';
//
// class UserScreen extends StatefulWidget {
//   @override
//   _UserScreenState createState() => _UserScreenState();
// }
//
// class _UserScreenState extends State<UserScreen> {
//   late Future<List<User>> _futureUsers;
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _futureUsers = UserService.getUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Users'),
//       ),
//       body: FutureBuilder<List<User>>(
//         future: _futureUsers,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return LoadingIndicator();
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final users = snapshot.data!;
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: users.length,
//                     itemBuilder: (context, index) {
//                       final user = users[index];
//                       return ListTile(
//                         title: Text('${user.firstName} ${user.lastName}'),
//                         subtitle: Text(user.email),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 _firstNameController.text = user.firstName;
//                                 _lastNameController.text = user.lastName;
//                                 _emailController.text = user.email;
//                                 _showFormDialog(context, user);
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () async {
//                                 await UserService.deleteUser(user.id);
//                                 setState(() {
//                                   _futureUsers = UserService.getUsers();
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 CustomButton(
//                   text: 'Add User',
//                   onPressed: () {
//                     _firstNameController.clear();
//                     _lastNameController.clear();
//                     _emailController.clear();
//                     _showFormDialog(context, null);
//                   },
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   void _showFormDialog(BuildContext context, User? user) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(user == null ? 'Add User' : 'Edit User'),
//         content: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CustomTextField(
//                 controller: _firstNameController,
//                 label: 'First Name',
//               ),
//               CustomTextField(
//                 controller: _lastNameController,
//                 label: 'Last Name',
//               ),
//               CustomTextField(
//                 controller: _emailController,
//                 label: 'Email',
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           CustomButton(
//             text: 'Cancel',
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           CustomButton(
//             text: user == null ? 'Add' : 'Update',
//             onPressed: () async {
//               if (_formKey.currentState!.validate()) {
//                 final newUser = User(
//                   id: user?.id ?? 0,
//                   firstName: _firstNameController.text,
//                   lastName: _lastNameController.text,
//                   email: _emailController.text,
//                 );
//
//                 if (user == null) {
//                   await UserService.createUser(newUser);
//                 } else {
//                   await UserService.updateUser(newUser);
//                 }
//
//                 setState(() {
//                   _futureUsers = UserService.getUsers();
//                 });
//
//                 Navigator.of(context).pop();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
