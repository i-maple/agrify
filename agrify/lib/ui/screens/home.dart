import 'package:agrify/ui/components/market_tile.dart';
import 'package:agrify/logic/controllers/auth_methods.dart';
import 'package:agrify/ui/components/weather_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './weatherHomePage.dart';
import '../utilities/colors.dart';
import '../utilities/constant.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool isLoggedIn = AuthMethods().authState;
  int currentIndex = 0;

  Widget setBottombarPage() {
    switch (currentIndex) {
      case 0:
        return HomePage(isLoggedIn: isLoggedIn);
        break;
      case 1:
        return Container(
          child: Text('Cart'),
        );
      case 2:
        return WeatherPage();
      default:
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarySwatch,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: kPrimarySwatch,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: kPrimarySwatch,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.cloudy_snowing,
                color: kPrimarySwatch,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.comment,
                color: kPrimarySwatch,
              ),
              label: '')
        ],
      ),
      body: SafeArea(
        child: setBottombarPage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.isLoggedIn,
  }) : super(key: key);

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // grettings row
      spacer(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hi, Jared!
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Namaste, ${isLoggedIn ? "Nishant" : "Agriculturist!"}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat.yMMMd().format(DateTime.now()),
                      style: TextStyle(
                        color: kPrimarySwatch.shade100,
                      ),
                    )
                  ],
                ),
                //Notification
                Container(
                  decoration: BoxDecoration(
                    //color: kPrimarySwatch.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: isLoggedIn
                      ? GestureDetector(
                          child: CircleAvatar(),
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                        )
                      : IconButton(
                          onPressed: () async {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          icon: const Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                        ),
                )
              ],
            ),

            SizedBox(
              height: 28,
            ),

            //search bar
            Container(
              decoration: BoxDecoration(
                color: kPrimarySwatch.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            // weather
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weather Updates',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),

            SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    WeatherCard(
                      weatherFace: '☁️',
                    ),
                    Text(
                      'Yesterday',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Cloudy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    WeatherCard(
                      weatherFace: '☀️',
                    ),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Sunny',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    WeatherCard(
                      weatherFace: '🌧️',
                    ),
                    Text(
                      'Tommorrow',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Rainy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Alert! Hailstone Tomorrow!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Icon(
              Icons.close,
              color: Colors.white,
            ),
          ],
        ),
        width: double.infinity,
      ),
      // weather

      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          color: Colors.grey[100],
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MarketPlace',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  spacer(height: 10),
                  MarketTile(
                    text: 'Fertilizer',
                    price: 499,
                    icon: Icons.home,
                  ),
                  MarketTile(
                    text: 'Grains',
                    price: 120,
                    icon: Icons.grain,
                  ),
                  MarketTile(
                    text: 'Sushill',
                    price: 1,
                    icon: Icons.person,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
