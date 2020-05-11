import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Color mainStyle = Colors.lightGreen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exploding Dice',
      theme: ThemeData(
        primarySwatch: mainStyle,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Exploding Dice! 💥🎲'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // We start at 2 dice, since that's the minimum to use for any skill
  int _counter = 2;
  var diceResult = List<Widget>();
  var diceBag = new Random();
  String possibleRolls = "⚀⚁⚂⚃⚄⚅";

  void _incrementCounter() {
    setState(() {
      _counter++;
      // Always clear out the last roll when changing dice
      diceResult.clear();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        // Only decrease down to 0
        _counter--;
      // Always clear out the last roll when changing dice
        diceResult.clear();
      }
    });
  }

  void _rollDice() {
    setState(() {
      int diceTotal = 0;
      // Clear out the last roll
      diceResult.clear();
      for (int i=0; i<_counter; i++) {
        diceTotal += _addDice(diceResult, 0);
      }
      diceResult.insert(
        0,
        Text(
          "Totalt: "+diceTotal.toString(), 
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }

  int _addDice(List<Widget> result, int level) {
    int diceResult = 1+diceBag.nextInt(6);
    if (diceResult == 6) {
      result.add(
        Text("➣"*level + " " + possibleRolls[diceResult-1] + " 💥",
          style: TextStyle(fontSize: 30.0),
        ),
      );
      // Roll two new dice instead on this one
      diceResult = _addDice(result, level+1)+_addDice(result, level+1);
    }  else {
      result.add(
        Text("➣"*level + " " + possibleRolls[diceResult-1],
          style: TextStyle(fontSize: 30.0),
        ),
      );
    }
    return diceResult;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView (
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Antal tärningar:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Minus-knapp
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  tooltip: 'Minska',
                  child: Icon(Icons.remove),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                // Plus-knapp
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Öka',
                  child: Icon(Icons.add),
                ),
              ], 
            ), 
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: _rollDice,
              child: Text(
                "Rulla!",
                style: TextStyle(fontSize: 20.0),
              ),
            ), 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: diceResult,),
          ],
        ),
      ),
    );
  }
}
