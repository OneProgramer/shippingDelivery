import 'package:flutter/material.dart';
import 'package:shippingDelivery/home_page.dart';
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 90.0),
              child: Icon(
                Icons.local_shipping,
                color: Colors.white,
                size: 80.0,
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: _animation,
              child: Text(
                'Welcome to our shipping and delivery company',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
               Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }));
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                      decoration: TextDecoration.underline,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
