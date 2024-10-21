import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/app_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() {
    // ignore: avoid_print
    print('create State');
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final Logger logger = Logger();

  // Iconos
  final String winIconPath = 'assets/icons/win_icon.svg';
  final String loseIconPath = 'assets/icons/lose_icon.svg';
  final String continueIconPath = 'assets/icons/continue_icon.svg';
  
  // Campos para las preferencias
  String _userName = ''; // Nombre de usuario
  int _counter = 0;      // Contador

  // Método para cargar las preferencias
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Usuario'; // Carga el nombre de usuario desde las preferencias
      _counter = prefs.getInt('counter') ?? 0; // Carga el contador desde las preferencias
    });
  }

  // Método para guardar el contador
  Future<void> _saveCounter(int counter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
  }

  _MyHomePageState() {
    // ignore: avoid_print
    print('constructor, mounted: $mounted');
  }

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('initState, mounted: $mounted');
    _loadPreferences(); // Cargar las preferencias al iniciar la pantalla
    // Usar addPostFrameCallback para registrar la acción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppData>().addAction("Acceso a la pantalla principal");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ignore: avoid_print
    print('didChangeDependencies, mounted: $mounted');
  }

  @override
  void setState(VoidCallback fn) {
    // ignore: avoid_print
    print('setState');
    super.setState(fn);
  }

  String _getMessage(int counter) {
    if (counter == 10) {
      return "Victoria!";
    } else if (counter == 5) {
      return "Derrota!";
    } else {
      return "Continúa jugando";
    }
  }

  String _getIconPath(int counter) {
    if (counter == 10) {
      return winIconPath;
    } else if (counter == 5) {
      return loseIconPath;
    } else {
      return continueIconPath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                'Menú de navegación',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Contador'),
              onTap: () {
                // Cierra el drawer y navegar a Home
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.details),
              title: const Text('Detalle'),
              onTap: () {
                // Navegar a la pantalla Detalle
                Navigator.pushNamed(context, '/detail');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () {
                // Navegar a la pantalla Sobre
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Auditoría'),
              onTap: () {
                // Navegar a la pantalla Auditoría
                Navigator.pushNamed(context, '/audit');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.pushNamed(context, '/preference')
                    .then((_) => _loadPreferences()); // Llamada a _loadPreferences al volver
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hola $_userName', // Mensaje de bienvenida
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                SvgPicture.asset(
                  _getIconPath(_counter),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  _getMessage(_counter),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _counter--;
                          _saveCounter(_counter); // Guardar el contador actualizado
                        });
                      },
                      child: const Icon(Icons.remove),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _counter++;
                          _saveCounter(_counter); // Guardar el contador actualizado
                        });
                      },
                      child: const Icon(Icons.add_circle),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _counter = 0;
                          _saveCounter(_counter); // Guardar el contador al reiniciar
                        });
                      },
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showFloatingButton(_counter),
    );
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ignore: avoid_print
    print('didUpdateWidget, mounted: $mounted');
  }

  @override
  void deactivate() {
    super.deactivate();
    // ignore: avoid_print
    print('deactivate, mounted: $mounted');
  }

  @override
  void dispose() {
    super.dispose();
    // ignore: avoid_print
    print('dispose, mounted: $mounted');
  }

  @override
  void reassemble() {
    super.reassemble();
    // ignore: avoid_print
    print('reassemble, mounted: $mounted');
  }

  Widget? _showFloatingButton(int counter) {
    if (counter == 5 || counter == 10) {
      return FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter = 0;
            _saveCounter(_counter); // Guardar el reinicio
          });
        },
        tooltip: 'Reiniciar',
        child: const Icon(Icons.refresh),
      );
    } else {
      return null;
    }
  }
}
