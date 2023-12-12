import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commmerce_firebase/Screens/favourite.dart';
import 'package:e_commmerce_firebase/Screens/home.dart';
import 'package:e_commmerce_firebase/Screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Screens/cart.dart';
class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int pageIndex=0;
final pages=[
  HomePage(),
  Favourite(),
  Cart(),
  Profile()
];
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(

        body: pages[pageIndex],
        bottomNavigationBar: CurvedNavigationBar(
            color: Colors.blue,
            backgroundColor: Colors.white,
            index: pageIndex,
            buttonBackgroundColor: Colors.black,
            animationDuration: Duration(milliseconds: 100),
            animationCurve: Curves.easeIn,
            height: 60.0,
            onTap: (value) {
              setState(() {
                pageIndex=value;
              });
            },
            items: [
              Icon(Icons.home_outlined,color: Colors.white),
              Icon(Icons.favorite,color: Colors.white),
               Icon(Icons.shopping_cart_sharp,color: Colors.white),
              Icon(Icons.person_pin,color: Colors.white),

            ]),
      ),
    );
  }
}
