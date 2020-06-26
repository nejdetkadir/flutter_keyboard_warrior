import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int step = 0;
  TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var shownWidget;

    if (step == 0) {
      shownWidget = <Widget>[
        Container(
          padding: EdgeInsets.only(right: 25, left: 25),
          child: TextField(
            controller: userName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "What's your name?",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 25, left: 25),
          margin: EdgeInsets.only(top: 20),
          child: RaisedButton(
            onPressed: () {
              if (userName.text.toString().length < 2) {
                Fluttertoast.showToast(
                    msg: "It must be of 3 characters minimum",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 15.0
                );
              }
            },
            color: Colors.cyan,
            child: Text(
              "START",style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ];
    } else if (step == 1) {
      shownWidget = <Widget>[
        Text("step 1")
      ];
    } else {
      shownWidget = <Widget>[
        Text("step 2")
      ];
    }

    return Scaffold(
        backgroundColor: Colors.cyan,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 10,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(80.0), topRight: Radius.circular(80.0)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: shownWidget,
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ));
  }
}
