import 'package:shippingDelivery/customer_page.dart';
import 'package:shippingDelivery/createAcc.dart';
import 'package:shippingDelivery/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 68, 115, 196),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.app_registration,
                    color: Color.fromARGB(255, 68, 115, 196),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.login,
                    color: Color.fromARGB(255, 68, 115, 196),
                  ),
                ),
              ]),
              Expanded(
                child: TabBarView(children: [
                  Customerpage(),
                  AccountCreationScreen(),
                  LoginScreen(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
