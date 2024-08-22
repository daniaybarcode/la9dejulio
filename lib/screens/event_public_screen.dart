//event_public_screen.dart

import 'package:flutter/material.dart';
import 'package:nuevedejulio/models/event_model.dart';
import 'package:nuevedejulio/services/api_service.dart';
import 'package:nuevedejulio/services/event_service.dart';
import 'package:nuevedejulio/widgets/loading_indicator.dart';
import 'package:nuevedejulio/screens/simple_reservation_screen.dart';

class EventPublicScreen extends StatefulWidget {
  @override
  _EventPublicScreenState createState() => _EventPublicScreenState();
}

class _EventPublicScreenState extends State<EventPublicScreen> {
  late Future<List<Event>> _futureEvents;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    setState(() {
      _futureEvents = EventService.getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Event>>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final events = snapshot.data!;
            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SimpleReservationScreen(event: event),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    color: Colors.grey[900],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (event.image.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                ApiService.baseUrl + "/uploads/" + event.image,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(height: 10),
                          Text(
                            event.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            event.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            event.date.toIso8601String(),
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
