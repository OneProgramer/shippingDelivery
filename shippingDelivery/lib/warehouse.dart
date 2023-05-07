import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Albums> createAlbum(String productName) async {
  final http.Response response = await http.post(
    Uri.parse('http://localhost:3000/product/id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'name': productName, 'productCase': 'warehouse'}),
  );

  return Albums.fromJson(jsonDecode(response.body));
}

class Albums {
  final bool value;

  const Albums({required this.value});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
      value: json['value'],
    );
  }
}

class Album {
  final List value;

  const Album({
    required this.value,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      value: json['value'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('http://localhost:3000/product'));

  return Album.fromJson(jsonDecode(response.body));
}

late Future<Album> futureAlbum = fetchAlbum();

class WarehouseAdminPage extends StatefulWidget {
  @override
  _Warehouseadminpage createState() => _Warehouseadminpage();
}

class _Warehouseadminpage extends State<WarehouseAdminPage> {
  String productId = '';
  String result = '';
  String results = '';
  Future<Albums>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildColumn());
  }

  Padding buildColumn() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Hello Warehouse Adminstrator!",
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
          SizedBox(height: 20),
          (futureAlbum == '') ? Text('') : Text("Here Are Products You Have!"),
          FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              List arr = [];
              if (snapshot.hasData) {
                for (var i = 0; i < snapshot.data!.value.length; i++) {
                  if (snapshot.data!.value[i]['productCase'] == 'warehouse') {
                    arr.add(
                      Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(""),
                              Text(
                                "Product_Name:  " +
                                    snapshot.data!.value[i]['name'],
                                textAlign: TextAlign.center,
                              ),
                              Text(""),
                              Text(
                                "Quantity:   " +
                                    snapshot.data!.value[i]['quantity']
                                        .toString(),
                                textAlign: TextAlign.center,
                              ),
                              Text(""),
                              Text(
                                "Price:      " +
                                    snapshot.data!.value[i]['price'].toString(),
                                textAlign: TextAlign.center,
                              ),
                              Text(""),
                            ],
                          )),
                    );
                  }
                }
                return Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    textDirection: TextDirection.ltr,
                    verticalDirection: VerticalDirection.down,
                    children: [...arr]);
              } else if (!snapshot.hasData) {
                return Center(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Text('')),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter Product Name',
              fillColor: Color(0xffFCF6F5),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onChanged: (value) {
              setState(() {
                productId = value;
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text(
              'Confirm Recieve',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                if (productId.length < 1) {
                  results = 'please fill data!';
                } else {
                  _futureAlbum = createAlbum(productId);
                }
              });
            },
          ),
          SizedBox(height: 16),
          Text(results),
          (_futureAlbum == null) ? Text('') : bs(),
        ],
      ),
    );
  }

  FutureBuilder<Albums> bs() {
    return FutureBuilder<Albums>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.value == true) {
            return Text(
              'Taked Product Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return Text(
              'Can`t take this Product!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        } else if (!snapshot.hasData) {
          return Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Text('');
      },
    );
  }
}
