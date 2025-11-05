import 'package:flutter/material.dart';

void main() {
  runApp(MyStopWatch());
}

class MyStopWatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop watch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stop Watch Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _counter2 = 0;
  String _stringa = "START";
  String _stringa2 = "PAUSE";

  void _incrementCounter() {
    setState(() {
      _counter++;
      if(_counter > 2) _counter = 0;
      if(_counter == 0) {
        _stringa = " ";
        _stringa = "START";
      } else if(_counter == 1) {
        _stringa = " ";
        _stringa = "STOP";
      } else {
        _stringa = " ";
        _stringa = "RESET";
      }

    });
  }

  void _decrementCounter() {
    setState(() {
      _counter2++;
      if(_counter2 > 1) _counter2 = 0;
      if(_counter2 == 0) {
        _stringa2 = " ";
        _stringa2 = "PAUSE";
      } else {
        _stringa2 = " ";
        _stringa2 = "RESUME";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_stringa',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_stringa2',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          const SizedBox(width: 70),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.exposure_minus_1),
          )
        ],
      ),
    );
  }
}
