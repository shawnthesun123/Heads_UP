import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/scheduler.dart';
import 'package:sensors/sensors.dart';

import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Baby Names',
//       home: MyHomePage(),
//     );
//   }
// }



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() {
//     return _MyHomePageState();
//   }
// }

class _MyHomePageState extends State<MyHomePage> {
  double x;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        // x = num.parse(event.x.toStringAsFixed(2));
        // y = num.parse(event.y.toStringAsFixed(2));
        // z = num.parse(event.z.toStringAsFixed(2));
        x = event.x;
      });
    }); //get the sensor data and set then to the data types
  }


  @override
  Widget build(BuildContext context) {
    if (x >= 9.00) {
      setState(() {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new CorrectScreen()));
        });
      });
    }

    if (x <= -5.00) {
      setState(() {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new passedScreen()));
        });
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Sensor Library"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Sensor Test",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(num.parse(x.toStringAsFixed(2)).toStringAsFixed(2),
                    style: TextStyle(fontSize: 20.0)),
              )
            ],
          ),
        ));
  }
}

class CorrectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (x < 9.00) {
    //   setState(() {
    //
    //     Navigator.pop(
    //         context);
    //
    //
    //   });
    // }
    Timer(Duration(seconds: 2), () {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(
            context);
      });
    });

    return Container(
      decoration: new BoxDecoration(color: Colors.green),
      child: new Center(
        child: new Text("Correct"),
      ),
    );
  }

}

class passedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // if (x < 9.00) {
    //   setState(() {
    //
    //     Navigator.pop(
    //         context);
    //
    //
    //   });
    // }
    Timer(Duration(seconds: 2), () {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(
            context);
      });
    });
    return Container(
      decoration: new BoxDecoration(color: Colors.red),
      child: new Center(
        child: new Text(
          "Passed",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
    );
  }

}



class Record {
  final String name;
  final double votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
