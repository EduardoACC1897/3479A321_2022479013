import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/app_data.dart';

class AuditPage extends StatefulWidget {
  const AuditPage({super.key});

  @override
  State<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('initState, mounted: $mounted');
    // Usar addPostFrameCallback para registrar la acción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppData>().addAction("Acceso a la pantalla de Auditoría");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditoría'),
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          return ListView.builder(
            itemCount: appData.actions.length, // Cantidad de acciones
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(appData.actions[index]), // Mostrar cada acción
              );
            },
          );
        },
      ),
    );
  }
}
