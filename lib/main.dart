import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyStopWatch());
}

// classe estendente StatelessWidget (widget immutabile)
class MyStopWatch extends StatelessWidget {
  const MyStopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // titolo app
      title: 'Stop watch - Jacopo Olivo',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 0, 100, 0),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Stop Watch'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// classe estendente StatefulWidget (widget mutabile)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // stato del primo bottone:
  // 0 = stop, 1 = reset, 2 = start (di default è start)
  int _counterState = 2;

  // stato del secondo bottone:
  // 0 = resume, 1 = pause
  int _counterPause = 0;

  // etichette per debug
  String _stringa = "START";
  String _stringa2 = "RESUME";

  bool _paused = false;   // true se è in pausa

  int _seconds = 0;       // secondi conteggiati (totali)

  // stream per i tick
  final StreamController<int> _tickController = StreamController<int>.broadcast();

  // stream per i secondi
  final StreamController<int> _secondController = StreamController<int>.broadcast();

  int _tickCounter = 0;    // variabile che conta i tick (ogni 10 tick -> 1 secondo)

  void _startStreams() {
    // genera un tick ogni 100 ms e se il cronometro non è in pausa li aggiunge allo stream
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_paused) {
        _tickController.add(_tickCounter++);
      }
    });

    // ascolta lo stream dei tick e ogni 10 tick aggiunge un secondo
    _tickController.stream.listen((tick) {
      if (tick % 10 == 0 && tick != 0) {
        _secondController.add(_seconds + 1);
        setState(() {
          _seconds++;
        });
      }
    });
  }

  @override
  void initState() {       // metodo che viene eseguito una volta all'inizio del programma
    super.initState();
    _startStreams();
  }

  @override
  void dispose() {          // metodo che viene eseguito prima della chiusura del widget
    _tickController.close();
    _secondController.close();
    super.dispose();
  }

  // logica pulsante start/stop/reset
  void _changeState() {
    setState(() {
      _counterState++;
      if (_counterState > 2) _counterState = 0;

      if (_counterState == 0) {
        _stringa = "STOP";
        _paused = true;
      } else if (_counterState == 1) {
        _stringa = "RESET";
        _seconds = 0;
        _tickCounter = 0;
        _paused = true;
      } else {
        _stringa = "START";
        _paused = false;
      }
    });
  }

  // logica pulsante resume/pause
  void _pauseResume() {
    setState(() {
      _counterPause++;
      if (_counterPause > 1) _counterPause = 0;

      if (_counterPause == 0) {
        _stringa2 = "RESUME";
        _paused = false;
      } else {
        _stringa2 = "PAUSE";
        _paused = true;
      }
    });
  }

  // metodo che converte i secondi nel formato minuti:secondi
  String _convertCounter() {
    final mm = (_seconds ~/ 60).toString().padLeft(2, '0');
    final ss = (_seconds % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // stampa del cronometro formattato
            Text(
              _convertCounter(),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // stampa stati (debug)
            Text('Stato: $_stringa'),
            Text('Pausa - Resume: $_stringa2'),
            const SizedBox(height: 20),
            // aggiunta della barra progressiva (60 secondi)
            LinearProgressIndicator(
              value: (_seconds % 60) / 60,
              minHeight: 8,
              backgroundColor: Colors.green[100],
              color: Colors.green,
            ),
          ],
        ),
      ),
      // row contenente i bottoni start/pause
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _changeState,
            tooltip: 'Stato stop watch',
            backgroundColor: Colors.greenAccent,
            child: _counterState == 0
                ? const Icon(Icons.stop)
                : _counterState == 1
                ? const Icon(Icons.refresh)
                : const Icon(Icons.play_arrow),
          ),
          const SizedBox(width: 50),
          FloatingActionButton(
            onPressed: _pauseResume,
            tooltip: _paused ? 'Pause' : 'Resume',
            backgroundColor: Colors.teal,
            child: Icon(_paused ? Icons.play_arrow : Icons.pause),
          ),
        ],
      ),
    );
  }
}
