import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/scheduler.dart';
import 'package:sensors/sensors.dart';

import 'dart:async';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]).then((_){
    runApp(MyApp());
  });
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


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Press to Play'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => firstRoute()),
            );
          },
        ),
      ),
    );
  }
}

class firstRoute extends StatefulWidget {
  @override
  _firstRouteState createState() => _firstRouteState();
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() {
//     return _MyHomePageState();
//   }
// }

class _firstRouteState extends State<firstRoute> {
  AccelerometerEvent event;
  AccelerometerEvent origin_event;
  StreamSubscription accel;
  StreamSubscription origin_accel;
  double x;
  double origin_x;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accel = accelerometerEvents.listen((AccelerometerEvent eve) {
      setState(() {
        event = eve;
        x = event.x;
      });
    });
    origin_accel = accelerometerEvents.listen((AccelerometerEvent eve) {
      setState(() {
        origin_event = eve;
        origin_x = origin_event.x;
      });
    });

  }




  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      origin_accel.pause();
    });

    try {
      if (x >= origin_x + 1 || x >= 10) {
        accel.pause();
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new CorrectScreen()));
          });
        });
        Timer(Duration(seconds: 2), () {
          accel.resume();
        });
      }
    } catch (err) {
      print('Caught error: $err');
    }

    try{
      if (x <= origin_x - 2) {
        accel.pause();
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new passedScreen()));
          });
        });
        Timer(Duration(seconds: 2), () {
          accel.resume();
        });
      }
    } catch (err) {
      print('Caught error: $err');
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(num.parse(origin_x.toStringAsFixed(2)).toStringAsFixed(2),
                    style: TextStyle(fontSize: 20.0)),
              )
            ],
          ),
        ));
  }
}

class secondRoute extends StatefulWidget {
  @override
  _secondRouteState createState() => _secondRouteState();
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() {
//     return _MyHomePageState();
//   }
// }

class _secondRouteState extends State<secondRoute> {
  AccelerometerEvent event;
  AccelerometerEvent origin_event;
  StreamSubscription accel;
  StreamSubscription origin_accel;
  double x;
  double origin_x;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accel = accelerometerEvents.listen((AccelerometerEvent eve) {
      setState(() {
        event = eve;
        x = event.x;
      });
    });
    origin_accel = accelerometerEvents.listen((AccelerometerEvent eve) {
      setState(() {
        origin_event = eve;
        origin_x = origin_event.x;
      });
    });

  }




  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      origin_accel.pause();
    });

    try {
      if (x >= origin_x + 1 || x >= 10) {
        accel.pause();
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new CorrectScreen()));
          });
        });
        Timer(Duration(seconds: 2), () {
          accel.resume();
        });
      }
    } catch (err) {
      print('Caught error: $err');
    }

    try{
      if (x <= origin_x - 2) {
        accel.pause();
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new passedScreen()));
          });
        });
        Timer(Duration(seconds: 2), () {
          accel.resume();
        });
      }
    } catch (err) {
      print('Caught error: $err');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Page 2"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Second Page Test",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(num.parse(x.toStringAsFixed(2)).toStringAsFixed(2),
                    style: TextStyle(fontSize: 20.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(num.parse(origin_x.toStringAsFixed(2)).toStringAsFixed(2),
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
    Timer(Duration(seconds: 1), () {
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
    Timer(Duration(seconds: 1), () {
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
