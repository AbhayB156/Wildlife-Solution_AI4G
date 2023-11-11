// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_solution/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  Query dbRef = FirebaseDatabase(
          databaseURL:
              'https://wildlife-solution-default-rtdb.asia-southeast1.firebasedatabase.app')
      .ref()
      .child('Device_id');

  Widget listItem({required Map device}) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        color: Colors.teal[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Recognised: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  device['recognised'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Time-Stamp: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  device['timestamp'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Day: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  device['day'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'PM_2.5(ug/m3): ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Text(
                  device['PM25'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Wild-Life'),
        backgroundColor: Colors.blueGrey[600],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.grey[800],
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.grey[800]),
              ))
        ],
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map device = snapshot.value as Map;
            device['key'] = snapshot.key;
            return listItem(device: device);
          },
        ),
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   // const Home({super.key});
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[100],
//       appBar: AppBar(
//         title: Text('Wild-Life'),
//         backgroundColor: Colors.blueGrey[600],
//         elevation: 0.0,
//         actions: <Widget>[
//           TextButton.icon(
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//               icon: Icon(
//                 Icons.person,
//                 color: Colors.grey[800],
//               ),
//               label: Text(
//                 'Logout',
//                 style: TextStyle(color: Colors.grey[800]),
//               ))
//         ],
//       ),
//     );
//   }
// }
