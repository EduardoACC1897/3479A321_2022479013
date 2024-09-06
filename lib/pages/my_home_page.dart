import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final Logger logger = Logger();

  // Paths for the icons
  final String winIconPath = 'assets/icons/win_icon.svg';
  final String loseIconPath = 'assets/icons/lose_icon.svg';
  final String continueIconPath = 'assets/icons/continue_icon.svg';

  String _getMessage() {
    if (_counter == 10) {
      return "Victoria!";
    } else if (_counter == 5) {
      return "Derrota!";
    } else {
      return "Continúa jugando";
    }
  }

  String _getIconPath() {
    if (_counter == 10) {
      return winIconPath;
    } else if (_counter == 5) {
      return loseIconPath;
    } else {
      return continueIconPath;
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      logger.i("Contador incrementa a $_counter");
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      logger.i("Contador disminuye a $_counter");
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      logger.i("Contador se reinicia a $_counter");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Navegar a la pantalla Acerca
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
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
                SvgPicture.asset(
                  _getIconPath(),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  _getMessage(),
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
                      onPressed: _decrementCounter,
                      child: const Icon(Icons.remove),
                    ),
                    ElevatedButton(
                      onPressed: _incrementCounter,
                      child: const Icon(Icons.add_circle),
                    ),
                    ElevatedButton(
                      onPressed: _resetCounter,
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla Detalle
                    Navigator.pushNamed(context, '/detail');
                  },
                  child: const Text('Detalle'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showFloatingButton(),
    );
  }

  Widget? _showFloatingButton() {
    // Mostrar el botón flotante si el contador es 5 o 10
    if (_counter == 5 || _counter == 10) {
      return FloatingActionButton(
        onPressed: _resetCounter,
        tooltip: 'Reiniciar',
        child: const Icon(Icons.refresh),
      );
    } else {
       // Ocultar el botón flotante si el contador no es 5 o 10
      return null;
    }
  }
}
