import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  var input_text="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
body: SafeArea(
  child:   Column(
    children: [
      ListTile(
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,)),
      title: Text("Search List",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18)),
      ),
      Container(
      height: 50,
      width: MediaQuery.of(context).size.width/1.1,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              input_text=value;
            });
          },
          decoration:   InputDecoration(
            hintText: "Search Here..",
            hintStyle: const TextStyle(color: Colors.blueGrey),
            enabledBorder: InputBorder.none,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
            prefixIcon: const Icon(Icons.search_outlined,color: Colors.teal,),
          ),
        ),
      ),
      ),

      SizedBox(height: 20,),
      Expanded(child: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").where("product-name",isEqualTo: input_text).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError){
           EasyLoading.showError("Something went wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
           return Center(child: Column(
             children: [
               Text("Loding..."),
               SizedBox(height: 10,),
               CircularProgressIndicator(),
             ],
           ));
        }
        return ListView(

          children:  snapshot.data!.docs.map((DocumentSnapshot document){
            Map<String, dynamic> datas=document.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Colors.white,
                child: ListTile(

      leading: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(datas["product-img"][1]),
      ),
                  title: Text(datas["product-name"],style: GoogleFonts.alata(fontWeight: FontWeight.bold)),
                  subtitle: Text("\$${datas["product-price"].toString()}",style: GoogleFonts.pacifico(fontWeight: FontWeight.bold,color: Colors.deepOrange,letterSpacing: 1)),
                ),
              ),
            );
          }).toList(),
        );
      },),
      ))
    ],
  ),
),
    );
  }
}
