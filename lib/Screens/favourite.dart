import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: Icon(Icons.favorite,color: Colors.white),
           title: Text("Favourite List",style: GoogleFonts.pacifico(color: Colors.black)),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-favourite-item").doc(FirebaseAuth.instance.currentUser?.email).collection("favouriteitems").snapshots(),
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
                          radius: 20,
                          backgroundImage: NetworkImage(_DocumentSnapshot["images"][0],),

                        ),
                        title: Text("${_DocumentSnapshot["name"]}",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.bold)),
                        subtitle: Text("\$ ${_DocumentSnapshot["price"].toString()}",style: GoogleFonts.pacifico(color: Colors.deepOrange)),
                        trailing: GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance.collection("users-favourite-item").doc(FirebaseAuth.instance.currentUser?.email).collection("favouriteitems").doc(_DocumentSnapshot.id).delete();
                            },
                            child: Icon(Icons.cut,color: Colors.red)),
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