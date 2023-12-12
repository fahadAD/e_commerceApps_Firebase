import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.shopping_cart,color: Colors.white),
          title: Text("Cart List",style: GoogleFonts.pacifico(color: Colors.black)),

        ),
         body: StreamBuilder(
           stream: FirebaseFirestore.instance.collection("users-cart-item").doc(FirebaseAuth.instance.currentUser?.email).collection("items").snapshots(),
             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError){
             EasyLoading.showError("Something is wrong");
          } if(snapshot.hasData){
             return ListView.builder(
               primary: false,
               shrinkWrap: true,
               itemCount: snapshot.data?.docs.length,
               itemBuilder: (BuildContext context, int index) {
                 DocumentSnapshot _DocumentSnapshot=snapshot.data!.docs[index];
                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: Card(
                     elevation: 15,
                     child: ListTile(
                       leading: CircleAvatar(
                         radius: 25,
                         backgroundImage: NetworkImage(_DocumentSnapshot["images"][0]),
                       ),
                       title: Text("${_DocumentSnapshot["name"]}",style: GoogleFonts.aboreto(color: Colors.black,fontWeight: FontWeight.bold)),
                       subtitle: Text("\$ ${_DocumentSnapshot["price"].toString()}",style: GoogleFonts.pacifico(color: Colors.deepOrange)),
                       trailing: GestureDetector(
                           onTap: () {
                         FirebaseFirestore.instance.collection("users-cart-item").doc(FirebaseAuth.instance.currentUser?.email).collection("items").doc(_DocumentSnapshot.id).delete();
                           },
                           child: Icon(Icons.delete_sweep_outlined,color: Colors.red)),
                     ),
                   ),
                 );
               },

             );
           }else{
             return Center(child: CircularProgressIndicator());
           }
             },),
      ),
    );
  }
}