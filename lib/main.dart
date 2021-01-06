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
        Timer(Duration(seconds: 3), () {
          accel.resume();
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new secondRoute()));
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
    try{
      return Scaffold(
          appBar: AppBar(
            title: Text("Flutter Sensor Library"),
            automaticallyImplyLeading: false,
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
    }catch (err) {
      print('Caught error: $err');
      return Container();
    }

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
          setState(() {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new thirdRoute()));
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
    try{
      return Scaffold(
          appBar: AppBar(
            title: Text("Second Page"),
            automaticallyImplyLeading: false,
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
    }catch (err) {
      print('Caught error: $err');
      return Container();
    }

  }
}

class thirdRoute extends StatefulWidget {
  @override
  _thirdRouteState createState() => _thirdRouteState();
}
class _thirdRouteState extends State<thirdRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes'), automaticallyImplyLeading: false,),

      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => record.reference.update({'votes': FieldValue.increment(1)}),       ),
      ),
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
  final int votes;
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
