import 'package:flutter/material.dart';
import '../utils/database_helper.dart';
import '../models/audit.dart';

class AuditPage extends StatefulWidget {
  const AuditPage({super.key});

  @override
  State<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  List<Audit> _audits = [];  // Lista para almacenar las auditorías

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('initState, mounted: $mounted');
    // Registrar la acción "Acceso a la pantalla de Auditoría" en la base de datos
    _logAccessToAuditPage();
    // Cargar las auditorías desde la base de datos
    _loadAudits();
  }

  // Método para registrar la acción en la base de datos
  Future<void> _logAccessToAuditPage() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertAudit(Audit(action: "Acceso a la pantalla de Auditoría"));
  }

  // Método para cargar las auditorías desde la base de datos
  Future<void> _loadAudits() async {
    final dbHelper = DatabaseHelper();
    List<Audit> audits = await dbHelper.getAudits();  // Obtener las auditorías
    setState(() {
      _audits = audits;  // Actualizar el estado con los datos recuperados
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auditoría'),
      ),
      body: ListView.builder(
        itemCount: _audits.length,  // Cantidad de auditorías
        itemBuilder: (context, index) {
          final audit = _audits[index];
          return ListTile(
            title: Text(audit.action),  // Mostrar la acción de auditoría
            subtitle: Text('ID: ${audit.id}'),  // Mostrar el ID de la auditoría
          );
        },
      ),
    );
  }
}
