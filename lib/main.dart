import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color mainStyle = Colors.blueGrey;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: mainStyle,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
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
  int _counter = 0;
  var diceResult = List<Widget>();
  var diceBag = new Random();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _rollDice() {
    setState(() {
      int diceTotal = 0;
      diceResult.clear();
      for (int i=0; i<_counter; i++) {
        int thisDice = _addDice(0);
        diceTotal += thisDice;
        diceResult.add(Text(thisDice.toString()));
      }
      diceResult.add(Text(
          "Totalt: "+diceTotal.toString(), 
          style: TextStyle(fontSize: 20.0),),
      );
    });
  }

  int _addDice(int level) {
    int diceResult = 1+diceBag.nextInt(6);
    //String dieResults = "u{2680}u{2681}u{2682}u{26803}u{2684}u{2685}";
    if (diceResult == 6) {
      diceResult = _addDice(level+1)+_addDice(level+1);
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
      body: Center (
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // ToDo: Fixa så att innehållet i den här kolumnen ligger längst upp på skärmen
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Antal tärningar:',
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
              color: Colors.blueGrey,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: _rollDice,
              child: Text(
                "Rulla!",
                style: TextStyle(fontSize: 20.0),
              ),
            ), 
            Column(children: diceResult,),
          ],
        ),
      ),
    );
  }
}
