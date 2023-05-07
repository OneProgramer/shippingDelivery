import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(
    String productName, String price, String location, String quantity) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/product'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': productName,
      'price': price,
      'location': location,
      'quantity': quantity,
      'productCase': 'admin',
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

void main() {
  runApp(const Admin());
}

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() {
    return _Admin();
  }
}

class _Admin extends State<Admin> {
  final TextEditingController productName = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController location = TextEditingController();
  Future<Album>? _futureAlbum;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child:
                (_futureAlbum == null ? buildColumn() : buildFutureBuilder())),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.admin_panel_settings,
          size: 100,
          color: Color.fromARGB(255, 68, 115, 196),
        ),
        Text(
          "Hello Admin!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        SizedBox(height: 30),
        Text(
          " Welcome Back",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 30),
        Text(
          " Here You Can Add Products",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Color.fromARGB(255, 68, 115, 196)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: productName,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ProductName',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Color.fromARGB(255, 68, 115, 196)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: quantity,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'quantity',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Color.fromARGB(255, 68, 115, 196)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: location,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ProductLocation',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Color.fromARGB(255, 68, 115, 196)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                controller: price,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Price',
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        MaterialButton(
          elevation: 5.0,
          color: Color.fromARGB(255, 68, 115, 196),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
          child: const Text(
            "Add Product",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          onPressed: () {
            setState(() {
              if (productName.text.length < 1 ||
                  price.text.length < 1 ||
                  quantity.text.length < 1 ||
                  location.text.length < 1) {
                result = 'Please Fill Data';
              } else {
                _futureAlbum = createAlbum(
                    productName.text, price.text, location.text, quantity.text);
              }
            });
          },
        ),
        SizedBox(height: 30),
        Text(
          result,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
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
          if (snapshot.data!.value == true) {
            result = 'The Product Added Successfully';
            productName.text = '';
            quantity.text = '';
            price.text = '';
            location.text = '';
          }
        } else if (!snapshot.hasData) {
          result = 'loading...';
        }

        return buildColumn();
      },
    );
  }
}
