import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0; // Contador
  // ignore: prefer_final_fields
  List<String> _actions = []; // Lista de acciones del usuario

  // Obtener el contador
  int get counter => _counter;

  // Obtener la lista de acciones
  List<String> get actions => _actions;

  // Método para incrementar el contador
  void incrementCounter() {
    _counter++;
    _actions.add('Contador incrementado a $_counter');
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado
  }

  // Método para decrementar el contador
  void decrementCounter() {
    _counter--;
    _actions.add('Contador decrementado a $_counter');
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado
  }

  // Método para reiniciar el contador
  void resetCounter() {
    _counter = 0;
    _actions.add('Contador reiniciado');
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado
  }

  // Método para agregar una acción personalizada
  void addAction(String action) {
    _actions.add(action);
    notifyListeners();
  }
}
