import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/app_data.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('initState, mounted: $mounted');
    // Usar addPostFrameCallback para registrar la acción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppData>().addAction("Acceso a la pantalla de Detalle");
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
            // Mostrar el contador usando Consumer
            Consumer<AppData>(
              builder: (context, appData, child) {
                return Text(
                  'Contador actual: ${appData.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla Acerca
                Navigator.pushNamed(context, '/about');
              },
              child: const Text('Acerca'),
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
