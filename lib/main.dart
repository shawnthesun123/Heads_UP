import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';



// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);
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
  double x, y, z;

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
              if (x >= 9.00)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Down: ",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              if (x <= -5.00)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Up: ",
                    style: TextStyle(fontSize: 20.0),
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







