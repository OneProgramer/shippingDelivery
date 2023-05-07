import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shippingDelivery/login.dart';

Future<Album> createAlbum(String email, String password, String name,
    String phone, dynamic account) async {
  if (account == true) {
    account = 'warehouse';
  } else {
    account = 'representative';
  }

  final http.Response response = await http.post(
    Uri.parse('http://localhost:3000/account/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'account': account
    }),
  );

  return Album.fromJson(jsonDecode(response.body));
}

class Album {
  final bool value;

  const Album({required this.value});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      value: json['value'],
    );
  }
}

class AccountCreationScreen extends StatefulWidget {
  @override
  _AccountCreationScreenState createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  bool _isWarehouseAdmin = true;
  Future<Album>? _futureAlbum;
  String result = '';
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _mobileFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder()),
    );
  }

  Column buildColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Icon(
          Icons.local_shipping,
          color: Colors.white,
          size: 50.0,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text('Warehouse Administrator'),
                          value: true,
                          groupValue: _isWarehouseAdmin,
                          onChanged: (value) {
                            setState(() {
                              _isWarehouseAdmin = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text('Shipping Representative'),
                          value: false,
                          groupValue: _isWarehouseAdmin,
                          onChanged: (value) {
                            setState(() {
                              _isWarehouseAdmin = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _emailFocusNode.unfocus();
                        _passwordFocusNode.unfocus();
                        _confirmPasswordFocusNode.unfocus();
                        _mobileFocusNode.unfocus();
                        _nameFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _nameFocusNode.unfocus();
                        _passwordFocusNode.unfocus();
                        _confirmPasswordFocusNode.unfocus();
                        _mobileFocusNode.unfocus();
                        _emailFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    obscureText: true,
                    onTap: () {
                      setState(() {
                        _nameFocusNode.unfocus();
                        _emailFocusNode.unfocus();
                        _confirmPasswordFocusNode.unfocus();
                        _mobileFocusNode.unfocus();
                        _passwordFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    obscureText: true,
                    onTap: () {
                      setState(() {
                        _nameFocusNode.unfocus();
                        _emailFocusNode.unfocus();
                        _passwordFocusNode.unfocus();
                        _mobileFocusNode.unfocus();
                        _confirmPasswordFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _mobileController,
                    focusNode: _mobileFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _nameFocusNode.unfocus();
                        _emailFocusNode.unfocus();
                        _passwordFocusNode.unfocus();
                        _confirmPasswordFocusNode.unfocus();
                        _mobileFocusNode.requestFocus();
                      });
                    },
                  ),
                  SizedBox(height: 40.0),
                  MaterialButton(
                      child: Text('Create Account'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 17.0, horizontal: 100.0),
                      onPressed: () {
                        setState(() {
                          if (_emailController.text.length < 1 ||
                              _passwordController.text.length < 1 ||
                              _mobileController.text.length < 1 ||
                              _nameController.text.length < 1 ||
                              _emailController.text.length < 1) {
                            result = 'please fill data!';
                          } else {
                            _futureAlbum = createAlbum(
                                _emailController.text,
                                _passwordController.text,
                                _nameController.text,
                                _mobileController.text,
                                _isWarehouseAdmin);
                          }
                        });
                      }),
                  Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.value == true) {
            return MaterialApp(
              home: LoginScreen(),
            );
          } else {
            result = 'account is already exist!';
          }
        } else if (!snapshot.hasData) {
          result = 'Loading...';
        }
        return buildColumn();
      },
    );
  }
}
