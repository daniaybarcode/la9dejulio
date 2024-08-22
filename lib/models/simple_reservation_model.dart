class SimpleReservation {
  final int idSimpleReservation;
  final int idEvent;
  final int idCliente;
  final String detalles;
  final int cantidad;

  SimpleReservation({
    required this.idSimpleReservation,
    required this.idEvent,
    required this.idCliente,
    required this.detalles,
    required this.cantidad,
  });

  factory SimpleReservation.fromJson(Map<String, dynamic> json) {
    return SimpleReservation(
      idSimpleReservation: json['idSimpleReservation'] ?? 0,
      idEvent: json['idEvent'] ?? 0,
      idCliente: json['idCliente'] ?? 0,
      detalles: json['detalles'] ?? '',
      cantidad: json['cantidad'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idSimpleReservation': idSimpleReservation,
      'idEvent': idEvent,
      'idCliente': idCliente,
      'detalles': detalles,
      'cantidad': cantidad,
    };
  }
}
