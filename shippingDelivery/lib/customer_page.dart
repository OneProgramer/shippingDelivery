import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Albums> createAlbum(String productName) async {
  final http.Response response = await http.post(
    Uri.parse('http://localhost:3000/product/buy'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': productName}),
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

// void main() => runApp(Customerpage());

class Customerpage extends StatefulWidget {
  @override
  _Customerpage createState() => _Customerpage();
}

late Future<Album> futureAlbum = fetchAlbum();

class _Customerpage extends State<Customerpage> {
  Future<Albums>? _futureAlbum;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    List arr = [];
                    if (snapshot.hasData) {
                      for (var i = 0; i < snapshot.data!.value.length; i++) {
                        if (snapshot.data!.value[i]['productCase'] ==
                            'warehouse') {
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
                                          snapshot.data!.value[i]['price']
                                              .toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                    (_futureAlbum == null) ? Text('') : bs(),
                                    ElevatedButton(
                                      child: Text('Buy'),
                                      onPressed: () {
                                        setState(() {
                                          _futureAlbum = createAlbum(
                                              snapshot.data!.value[i]['name']);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 100.0),
                                      ),
                                    ),
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
                            child: Text('loading data...')),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ));
  }

  FutureBuilder<Albums> bs() {
    return FutureBuilder<Albums>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.value == true) {
          } else {}
        } else if (!snapshot.hasData) {}
        return Text('');
      },
    );
  }
}
