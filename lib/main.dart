import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/scheduler.dart';
import 'package:sensors/sensors.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
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
            FirebaseFirestore.instance.collection('users').doc('user1').update({'score': 0});
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
  var r;
  String randomNum;


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
    Random rnd = new Random();
    var r = 1 + rnd.nextInt(9);
    randomNum = r.toString();
  }


  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      origin_accel.pause();
    });

    try {
      if (x >= origin_x + 1 ) {
        FirebaseFirestore.instance.collection('users').doc('user1').update({'score': FieldValue.increment(1)});
        accel.pause();
        setState(() {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new CorrectScreen()));
          });
        });
        Timer(Duration(seconds: 3), () {
          accel.resume();
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new firstRoute()));
            });
          });
          Timer(Duration(seconds: 2), () {
            accel.cancel();
            origin_accel.cancel();
          });
        });
      }
    } catch (err) {
      print('Caught error: $err');
    }

    try {
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
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new firstRoute()));
            });
          });
          Timer(Duration(seconds: 2), () {
            accel.cancel();
            origin_accel.cancel();
          });
        });
      }
    } catch (err) {
      print('Caught error: $err');
    }
    return new StreamBuilder(
        stream: FirebaseFirestore.instance.collection('baby')
            .doc(randomNum)
            .snapshots(),
        builder: (context, snapshot1) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users')
                  .doc('user1')
                  .snapshots(),
              builder: (context, snapshot2){
                if (!snapshot1.hasData || !snapshot2.hasData) {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text("First Page"),
                        automaticallyImplyLeading: false,
                      ),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Loading",
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ));
                }
                var userDocument = snapshot1.data;
                var usersDocument = snapshot2.data;
                try {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text("First Page"),
                        automaticallyImplyLeading: false,
                      ),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "First Page Test",
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
                              child: Text(
                                  num.parse(origin_x.toStringAsFixed(2)).toStringAsFixed(2),
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                userDocument["text"],
                                style: TextStyle(fontSize: 18.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Score: ${usersDocument["score"].toString()}" ,
                                style: TextStyle(fontSize: 18.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),

                              ),

                            )],
                        ),
                      ));
                }catch (err) {
                  print('Caught error: $err');
                  return Container();
                }
              }
          );
        }
    );
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
  final int score;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        score = map['score'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$score>";
}
