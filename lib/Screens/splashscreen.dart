import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Authentication/signup.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
    });
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(child: Text("National Computers Ltd",style: GoogleFonts.acme(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 28,letterSpacing: 2))),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.local_convenience_store_rounded,color: Colors.white),
                Icon(Icons.settings_input_hdmi_rounded,color: Colors.white),
                Center(child: Text("Computer Stores",style: GoogleFonts.pacifico(color: Colors.white,fontSize: 20))),

                Icon(Icons.computer_outlined,color: Colors.white),
                Icon(Icons.important_devices,color: Colors.white),
              ],
            ),
            SizedBox(height: 50,),
       CircularProgressIndicator(
         color: Colors.white,
         backgroundColor: Colors.orangeAccent,
       ),

           ],
        ),
      ),
    );
  }
}
