import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  String name = '';

  //Initialize and update counter if available
  @override
  void initState() {
    super.initState();
    _readCounter();
  }

  _incrementCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      //Save the current counter value
      preferences.setInt("counterKey", _counter);

      preferences.setString("myName", "Destiny Ed wants you to subscribe");
    });
  }

  _readCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      _counter = (preferences.getInt("counterKey") ?? 0);
      name = (preferences.getString("myName") ?? '');
    });
  }

  //Deleting
  _removeCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      // preferences.remove("counterKey");
      // preferences.remove("myName");
      preferences.clear();
    });

    _readCounter();
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
              '$name',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _removeCounter,
            tooltip: 'Increment',
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
