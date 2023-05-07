import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shippingDelivery/admin.dart';
import 'package:shippingDelivery/representative.dart';
import 'package:shippingDelivery/warehouse.dart';

Future<Album> createAlbum(String email, String password) async {
  final http.Response response = await http.post(
    Uri.parse('http://localhost:3000/account/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  return Album.fromJson(jsonDecode(response.body));
}

class Album {
  final String account;

  const Album({required this.account});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      account: json['account'],
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  Future<Album>? _futureAlbum;
  String result = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
            child:
                (_futureAlbum == null) ? buildColumn() : buildFutureBuilder()),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _passwordFocusNode.unfocus();
                        _emailFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _emailFocusNode.unfocus();
                        _passwordFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      setState(() {
                        if (_emailController.text.length < 1 ||
                            _passwordController.text.length < 1) {
                          result = 'please fill data!';
                        } else {
                          _futureAlbum = createAlbum(
                              _emailController.text, _passwordController.text);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 40.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


 FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.account == 'admin') {
            return MaterialApp(
              home: Admin(),
            );
          } else if (snapshot.data!.account == 'representative') {
            return MaterialApp(
              home: RepresentativePage(),
            );
          } else if (snapshot.data!.account == 'warehouse') {
            return MaterialApp(
              home: WarehouseAdminPage(),
            );
          } else {
            result = 'Email or Password is Wrong!';
          }
        } else if (!snapshot.hasData) {
          result = 'Loading...';
        }
        return buildColumn();
      },
    );
  }
}

