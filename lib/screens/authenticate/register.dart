import 'package:flutter/material.dart';
import 'package:wildlife_solution/services/auth.dart';
import 'package:wildlife_solution/shared/constants.dart';
import 'package:wildlife_solution/shared/loading.dart';

class Register extends StatefulWidget {
  // const Register({super.key});

  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String pass = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey[300],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[800],
              elevation: 0.0,
              title: Text('Sign-Up to Wild-Life'),
              actions: <Widget>[
                ElevatedButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey[800]),
                    ),
                    icon: Icon(Icons.person),
                    label: Text('Sign In'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecorations.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter your e-mail' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecorations.copyWith(hintText: 'Password'),
                        validator: (val) => val!.length < 6
                            ? 'Enter a password with 8+ characters'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            pass = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .registerWithEmailandPassword(email, pass);
                              if (result == null) {
                                setState(() {
                                  error = 'please input valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      )
                    ],
                  )),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/ADN-Innovators.png'),
                fit: BoxFit.scaleDown,
              )),
            ),
          );
  }
}
