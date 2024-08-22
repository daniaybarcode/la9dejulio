import 'package:flutter/material.dart';
import 'package:nuevedejulio/models/event_model.dart';
import 'package:nuevedejulio/models/simple_reservation_model.dart';
import 'package:nuevedejulio/services/simple_reservation_service.dart';

import '../services/api_service.dart';

class SimpleReservationScreen extends StatefulWidget {
  final Event event;

  SimpleReservationScreen({required this.event});

  @override
  _SimpleReservationScreenState createState() => _SimpleReservationScreenState();
}

class _SimpleReservationScreenState extends State<SimpleReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _detallesController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar para ${widget.event.name}'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mostrar la imagen del evento
                if (widget.event.image.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                     // "https://tusitio.com/uploads/" + widget.event.image,
                      ApiService.baseUrl + "/uploads/" + widget.event.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 16),
                Text(
                  widget.event.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Fecha: ${widget.event.date.toIso8601String()}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _detallesController,
                  decoration: InputDecoration(
                    labelText: 'Detalles adicionales',
                    hintText: 'Por ejemplo: Necesito menú vegano...',
                    filled: true,
                    fillColor: Colors.grey[800],
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa los detalles';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cantidadController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad de asistentes',
                    filled: true,
                    fillColor: Colors.grey[800],
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la cantidad';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitReservation,
                  child: Text('Reservar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitReservation() async {
    if (_formKey.currentState?.validate() ?? false) {
      final reservation = SimpleReservation(
        idSimpleReservation: 0, // Se generará en la base de datos
        idEvent: widget.event.idEvent,
        idCliente: 1, // Aquí deberías usar el ID del cliente actual
        detalles: _detallesController.text,
        cantidad: int.parse(_cantidadController.text),
      );

      bool success = await SimpleReservationService.createReservation(reservation);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reserva creada con éxito')),
        );
        Navigator.pop(context); // Volver a la pantalla anterior
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la reserva')),
        );
      }
    }
  }
}
