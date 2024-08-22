class Event {
  final int idEvent;
  final String name;
  final DateTime date;
  final String description;
  final String image;

  Event({
    required this.idEvent,
    required this.name,
    required this.date,
    required this.description,
    required this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      idEvent: json['id'] ?? 0,
      name: json['name'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idEvent,
      'name': name,
      'date': date.toIso8601String(),
      'description': description,
      'image': image,
    };
  }
}
