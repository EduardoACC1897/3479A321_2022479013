import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/database_helper.dart';
import '/models/audit.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({super.key});

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  String _userName = '';  // Campo para el nombre de usuario
  int _counter = 0;       // Campo para el contador

  // Método para cargar las preferencias
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
      _counter = prefs.getInt('counter') ?? 0;
      // Debug: muestra los valores cargados
      // ignore: avoid_print
      print('Counter value $_counter is loaded');
      // ignore: avoid_print
      print('Username value $_userName is loaded');
    });
  }

  // Método para guardar las preferencias
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setInt('counter', _counter);
  }

  // Método que actualiza el nombre de usuario
  void _updateUserName(String newName) {
    setState(() {
      _userName = newName;
    });
    _savePreferences(); // Guardar automáticamente al cambiar el nombre
  }

  // Método que actualiza el contador
  void _updateCounter(int newCounter) {
    setState(() {
      _counter = newCounter;
    });
    _savePreferences(); // Guardar automáticamente al cambiar el nombre
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();  // Carga las preferencias cuando se inicia la pantalla
    // Registrar la acción "Acceso a la pantalla de Preferencias" en la base de datos
    _logAccessToPreferencePage();
  }

  // Método para registrar la acción en la base de datos
  Future<void> _logAccessToPreferencePage() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertAudit(Audit(action: "Acceso a la pantalla de Preferencias"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            // Campo de texto para el nombre de usuario
            TextFormField(
              initialValue: _userName,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
              ),
              onChanged: _updateUserName, // Actualiza el nombre de usuario
            ),
            const SizedBox(height: 20),
            // Slider para modificar el valor del contador
            Slider(
              value: _counter.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              label: _counter.toString(),
              onChanged: (value) {
                _updateCounter(value.toInt()); // Actualiza el contador
              },
            ),
            const SizedBox(height: 20),
            // Botón para guardar las preferencias (opcional)
            ElevatedButton(
              onPressed: () {
                _savePreferences();
                Navigator.pop(context);  // Vuelve a la pantalla anterior
              },
              child: const Text('Guardar Preferencias'),
            ),
          ],
        ),
      ),
    );
  }
}
