class Audit {
  final int? id;
  final String action;

  Audit({this.id, required this.action});

  // Convertir un objeto Audit a un mapa (para insertarlo en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
    };
  }

  // Crear un objeto Audit a partir de un mapa (para leer de la base de datos)
  factory Audit.fromMap(Map<String, dynamic> map) {
    return Audit(
      id: map['id'],
      action: map['action'],
    );
  }

  @override
  String toString() {
    return 'Audit{id: $id, action: $action}';
  }
}
