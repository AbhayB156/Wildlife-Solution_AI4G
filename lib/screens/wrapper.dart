import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildlife_solution/models/user.dart';
import 'package:wildlife_solution/screens/authenticate/authenticate.dart';
import 'package:wildlife_solution/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usr?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    //return either home or auth widget
    // return Authenticate();
  }
}
