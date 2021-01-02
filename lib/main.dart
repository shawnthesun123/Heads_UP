import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:condition/condition.dart';
import "dart:async";

// enum WidgetMarker { graph, stats, info }
//
// class WidgetSwitchDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("WidgetSwitchDemo"),
//         ),
//         body: BodyWidget(),
//       ),
//     );
//   }
// }
//
// class BodyWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => BodyWidgetState();
// }
//
// class BodyWidgetState extends State<BodyWidget> with SingleTickerProviderStateMixin<BodyWidget> {
//   double x, y, z;
//
//   WidgetMarker selectedWidgetMarker = WidgetMarker.graph;
//   AnimationController _controller;
//   Animation _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       setState(() {
//         // x = num.parse(event.x.toStringAsFixed(2));
//         // y = num.parse(event.y.toStringAsFixed(2));
//         // z = num.parse(event.z.toStringAsFixed(2));
//         x = event.x;
//       });
//     }); //get the sensor data and set then to the data types
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             if (x >= 9.0)
//               selectedWidgetMarker = WidgetMarker.graph;
//             FlatButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWidgetMarker = WidgetMarker.graph;
//                 });
//               },
//               child: Text("Graph", style: TextStyle(color: (selectedWidgetMarker == WidgetMarker.graph) ? Colors.black : Colors.black12),),
//             ),
//             FlatButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWidgetMarker = WidgetMarker.stats;
//                 });
//               },
//               child: Text("Stats", style: TextStyle(color: (selectedWidgetMarker == WidgetMarker.stats) ? Colors.black : Colors.black12)),
//             ),
//             FlatButton(
//               onPressed: () {
//                 setState(() {
//                   selectedWidgetMarker = WidgetMarker.info;
//                 });
//               },
//               child: Text("Info", style: TextStyle(color: (selectedWidgetMarker == WidgetMarker.info) ? Colors.black : Colors.black12)),
//             ),
//           ],
//         ),
//         FutureBuilder(
//           future: _playAnimation(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return getCustomContainer();
//           },
//         )
//       ],
//     );
//   }
//
//   _playAnimation() {
//     _controller.reset();
//     _controller.forward();
//   }
//
//   Widget getCustomContainer() {
//     switch (selectedWidgetMarker) {
//       case WidgetMarker.graph:
//         return getGraphContainer();
//       case WidgetMarker.stats:
//         return getStatsContainer();
//       case WidgetMarker.info:
//         return getInfoContainer();
//     }
//     return getGraphContainer();
//   }
//
//   Widget getGraphContainer() {
//     return FadeTransition(
//       opacity: _animation,
//       child: Container(
//         color: Colors.red,
//         height: 200,
//       ),
//     );
//   }
//
//   Widget getStatsContainer() {
//     return FadeTransition(
//       opacity: _animation,
//       child: Container(
//         color: Colors.green,
//         height: 300,
//       ),
//     );
//   }
//
//   Widget getInfoContainer() {
//     return FadeTransition(
//       opacity: _animation,
//       child: Container(
//         color: Colors.blue,
//         height: 400,
//       ),
//     );
//   }
// }
// void main() => runApp(MyApp());
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

// class PlayerState {
//   final bool isInitial;
//   final bool isPassed;
//   final bool isCorrect;
//   final bool isDisplay;
//
//   PlayerState.initial({
//     this.isInitial = true, this.isPassed = false, this.isCorrect = false, this.isDisplay = false
// });
//   PlayerState.passed({
//     this.isInitial = false, this.isPassed = true, this.isCorrect = false, this.isDisplay = false
//   });
//   PlayerState.correct({
//     this.isInitial = false, this.isPassed = false, this.isCorrect = true, this.isDisplay = false
//   });
//   PlayerState.display({
//     this.isInitial = false, this.isPassed = false, this.isCorrect = false, this.isDisplay = true
//   });
// }
//
// class Player extends StatelessWidget {
//
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

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Baby Name Votes')),
//       body: _buildBody(context),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    if (x >= 9.00) {
      setState(() {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new CorrectScreen()));
      });
    }

    if (x <= 0.00) {
      setState(() {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new passedScreen()));
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

              // Table(
              //   border: TableBorder.all(
              //       width: 2.0,
              //       color: Colors.blueAccent,
              //       style: BorderStyle.solid),
              //   children: [
              //     TableRow(
              //       children: [
              //        Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(
              //                           "X Axis : ",
              //                           style: TextStyle(fontSize: 20.0),
              //                         ),
              //                       ),
              //                       Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Text(x.toStringAsFixed(2),
              //                             style: TextStyle(fontSize: 20.0)),
              //                       )
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             "Y Axis : ",
              //             style: TextStyle(fontSize: 20.0),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(y.toStringAsFixed(2),
              //               style: TextStyle(fontSize: 20.0)),
              //         )
              //       ],
              //     ),
              //     TableRow(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             "Z Axis : ",
              //             style: TextStyle(fontSize: 20.0),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(z.toStringAsFixed(2),
              //               style: TextStyle(fontSize: 20.0)),
              //         )
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ));
  }
}

class CorrectScreen extends StatefulWidget {
  @override
  _CorrectScreenPageState createState() => _CorrectScreenPageState();
}

class _CorrectScreenPageState extends State<CorrectScreen> {
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
    // if (x < 9.00) {
    //   setState(() {
    //
    //     Navigator.pop(
    //         context);
    //
    //
    //   });
    // }

    return new Container(
      decoration: new BoxDecoration(color: Colors.green),
      child: new Center(
        child: new Text("Correct"),
      ),
    );
  }
}

class passedScreen extends StatefulWidget {
  @override
  _passedScreenPageState createState() => _passedScreenPageState();
}

class _passedScreenPageState extends State<passedScreen> {
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
    // if (x < 9.00) {
    //   setState(() {
    //
    //     Navigator.pop(
    //         context);
    //
    //
    //   });
    // }

    return new Container(
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

//   Widget _buildBody(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('baby').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();
//
//         return _buildList(context, snapshot.data.documents);
//       },
//     );
//   }
//
//   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return ListView(
//       padding: const EdgeInsets.only(top: 20.0),
//       children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//     );
//   }
//
//   Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//     final record = Record.fromSnapshot(data);
//
//     return Padding(
//       key: ValueKey(record.name),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         child: ListTile(
//           title: Text(record.name),
//           trailing: Text(record.votes.toString()),
//           onTap: () => record.reference.updateData({'votes': FieldValue.increment(1)}),       ),
//       ),
//     );
//   }
// }
//
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
