import 'package:flutter/material.dart';
import 'package:wildlife_solution/services/auth.dart';
import 'package:wildlife_solution/shared/constants.dart';
import 'package:wildlife_solution/shared/loading.dart';

class Signin extends StatefulWidget {
  // const Signin({super.key});

  final Function toggleView;
  Signin({required this.toggleView});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
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
              title: Text('Sign-In to Wild-Life'),
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
                    label: Text('Register'))
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
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter a password with 8+ characters'
                            : null,
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
                                  .signInWithEmailandPassword(email, pass);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'could not sign in with the credentials';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            'Sign In',
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
