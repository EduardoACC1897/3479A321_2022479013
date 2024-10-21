import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/database_helper.dart';
import '/models/audit.dart';
class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  
  int _counter = 0; // Variable para almacenar el valor del contador

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('initState, mounted: $mounted');
    // Cargar el valor del contador desde SharedPreferences
    _loadCounter();
    // Registrar la acción "Acceso a la pantalla de Detalle" en la base de datos
    _logAccessToDetailPage();
  }

  // Método para registrar la acción en la base de datos
  Future<void> _logAccessToDetailPage() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertAudit(Audit(action: "Acceso a la pantalla de Detalle"));
  }

  // Método para cargar el contador desde SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0; // Si no existe, el valor es 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Esta es la pantalla de Detalle',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'del laboratorio 6 del módulo',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            // Mostrar el valor del contador cargado desde SharedPreferences
            Text(
              'Contador actual: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla Sobre
                Navigator.pushNamed(context, '/about');
              },
              child: const Text('Sobre'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Volver a la pantalla anterior
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
