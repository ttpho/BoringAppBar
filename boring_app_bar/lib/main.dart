import 'package:boring_app_bar/boring_appbar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Merry Christmas'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BoringAppBar(
          contentAppBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                // random background
              });
            },
          )
        ],
      )),
      body: Center(),
    );
  }
}
