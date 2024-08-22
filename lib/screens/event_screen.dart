// // screens/event_screen.dart
//
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:admin_digiticket2024/models/event_model.dart';
// import 'package:admin_digiticket2024/services/event_service.dart';
// import 'package:admin_digiticket2024/services/api_service.dart';
// import 'package:admin_digiticket2024/widgets/custom_button.dart';
// import 'package:admin_digiticket2024/widgets/custom_text_field.dart';
// import 'package:admin_digiticket2024/widgets/loading_indicator.dart';
//
// class EventScreen extends StatefulWidget {
//   @override
//   _EventScreenState createState() => _EventScreenState();
// }
//
// class _EventScreenState extends State<EventScreen> {
//   late Future<List<Event>> _futureEvents;
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _dateController = TextEditingController();
//   Uint8List? _imageBytes;
//   String? _imageName;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadEvents();
//   }
//
//   void _loadEvents() {
//     setState(() {
//       _futureEvents = EventService.getEvents();
//     });
//   }
//
//   Future pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _imageBytes = bytes;
//         _imageName = pickedFile.name;
//       });
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         _dateController.text = picked.toIso8601String();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Events'),
//       ),
//       body: FutureBuilder<List<Event>>(
//         future: _futureEvents,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return LoadingIndicator();
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final events = snapshot.data!;
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: events.length,
//                     itemBuilder: (context, index) {
//                       final event = events[index];
//                       return ListTile(
//                         leading: event.image.isNotEmpty
//                             ? Image.network(
//                           ApiService.baseUrl + "/uploads/" + event.image,
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         )
//                             : null,
//                         title: Text(event.name),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(event.description),
//                             Text(event.date.toIso8601String()),
//                           ],
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 _nameController.text = event.name;
//                                 _descriptionController.text = event.description;
//                                 _dateController.text = event.date.toIso8601String();
//                                 _imageBytes = null; // Reset image selection
//                                 _imageName = null; // Reset image name
//                                 _showFormDialog(context, event);
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () async {
//                                 await EventService.deleteEvent(event.id);
//                                 _loadEvents();
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 CustomButton(
//                   text: 'Add Event',
//                   onPressed: () {
//                     _nameController.clear();
//                     _descriptionController.clear();
//                     _dateController.clear();
//                     _imageBytes = null;
//                     _imageName = null;
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
//   void _showFormDialog(BuildContext context, Event? event) {
//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: Text(event == null ? 'Add Event' : 'Edit Event'),
//           content: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CustomTextField(
//                     controller: _nameController,
//                     label: 'Name',
//                   ),
//                   CustomTextField(
//                     controller: _descriptionController,
//                     label: 'Description',
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           controller: _dateController,
//                           label: 'Date',
//                           readOnly: true,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.calendar_today),
//                         onPressed: () {
//                           _selectDate(context);
//                         },
//                       ),
//                     ],
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       await pickImage();
//                       setState(() {});
//                     },
//                     child: Text(_imageBytes == null ? 'Pick Image' : 'Change Image'),
//                   ),
//                   if (_imageBytes != null)
//                     Container(
//                       margin: EdgeInsets.only(top: 10),
//                       child: Image.memory(
//                         _imageBytes!,
//                         height: 100,
//                         width: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             CustomButton(
//               text: 'Cancel',
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             CustomButton(
//               text: event == null ? 'Add' : 'Update',
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   final newEvent = Event(
//                     id: event?.id ?? 0,
//                     name: _nameController.text,
//                     date: DateTime.parse(_dateController.text),
//                     description: _descriptionController.text,
//                     image: event?.image ?? '',
//                   );
//
//                   if (event == null) {
//                     final createdEvent = await EventService.createEvent(newEvent);
//                     if (_imageBytes != null && _imageName != null) {
//                       await EventService.uploadEventImage(createdEvent.id, _imageBytes!, _imageName!);
//                     }
//                   } else {
//                     await EventService.updateEvent(newEvent);
//                     if (_imageBytes != null && _imageName != null) {
//                       await EventService.uploadEventImage(newEvent.id, _imageBytes!, _imageName!);
//                     }
//                   }
//
//                   _loadEvents();
//                   Navigator.of(context).pop(); // Cierra el modal después de actualizar
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
