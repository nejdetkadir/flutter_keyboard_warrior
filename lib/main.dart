import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';

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
  int score = 0;
  var sentence = "                                                    Bir berber bir berbere bre berber gel beraber berberistanda bir berber dükkânı açalım diye bar bar bağırmış Paşa tasıyla taşa taşa beş tas has üzüm hoşafı Paşanın tasası taşanın maşası pas tutmaz şaşılır makası".toLowerCase();
  TextEditingController userName = TextEditingController();

  void onWrote(String value) {
    if (sentence.trimLeft()[value.length-1] == value[value.length-1] && value.length > 0) {
      if (sentence.trimLeft()[value.length-1] != " ") {
        score++;
      }
    } else {
      setState(() {
        step++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var shownWidget;

    if (step == 0) {
      /*--------- STEP FIRST ---------*/
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
              } else {
                setState(() {
                  step++;
                });
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
      /*--------- STEP SECOND ---------*/
      shownWidget = <Widget>[
        Container(
          alignment: Alignment.center,
          height: 100,
          child: Marquee(
            text: sentence,
            style: TextStyle(fontSize: 24, letterSpacing: 2),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 125,
            startPadding: 0,
            accelerationDuration: Duration(seconds: 15),
            accelerationCurve: Curves.ease,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 25, left: 25),
          child: TextField(
            autofocus: true,
            onChanged: onWrote,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "GO GO GO!",
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  step++;
                });
              },
              color: Colors.cyan,
              child: Text(
                "BREAK",style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
        )

      ];
    } else {
      /*--------- STEP THIRD ---------*/
      shownWidget = <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 30),
          alignment: Alignment.center,
          child: Icon(
            Icons.done_outline,
            size: 50,
            color: Colors.cyan,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Hey ${userName.text.trim()}, your score : ${score}",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () {
              setState(() {
                step=1;
                score=0;
              });
            },
            color: Colors.cyan,
            child: Text(
              "TRY AGAIN",style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        )
      ];
    }

    return Scaffold(
        backgroundColor: Colors.cyan,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 9,
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
