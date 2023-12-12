 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bottomnavScr.dart';
 class UserForm extends StatefulWidget {
   @override
   _UserFormState createState() => _UserFormState();
 }

 class _UserFormState extends State<UserForm> {
    TextEditingController _nameController = TextEditingController();
   TextEditingController _phoneController = TextEditingController();
   TextEditingController _dobController = TextEditingController();
   TextEditingController _genderController = TextEditingController();
   TextEditingController _ageController = TextEditingController();
   List<String> gender = ["Male", "Female", "Other"];

   Future<void> _selectDateFromPicker(BuildContext context) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: DateTime(DateTime.now().year - 20),
       firstDate: DateTime(DateTime.now().year - 30),
       lastDate: DateTime(DateTime.now().year),
     );
     if (picked != null)
       setState(() {
         _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
       });
   }

   sendUserDataToDB()async{
     final FirebaseAuth _auth = FirebaseAuth.instance;
     var  currentUser = _auth.currentUser;
     CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
     return _collectionRef.doc(currentUser!.email).set({
       "name":_nameController.text,
       "phone":_phoneController.text,
       "dob":_dobController.text,
       "gender":_genderController.text,
       "age":_ageController.text,
     }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavigationPage()))).catchError((error)=>print("something is wrong. $error"));
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: Padding(
           padding: EdgeInsets.all(20),
           child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(
                   height: 20,
                 ),
                 Text(
                   "Submit the form to continue.",
                   style:
                   TextStyle(fontSize: 22, color: Colors.deepOrange),
                 ),
                 SizedBox(
                   height: 10,
                 ),
                 Text(
                   "We will not share your information with anyone.",
                   style: GoogleFonts.pacifico(color: Color(0xFFBBBBBB)),
                 ),
                 SizedBox(
                   height: 15,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                   child: ClipRRect(
                     borderRadius: const BorderRadius.all(Radius.circular(20)),
                     child: Card(
                       color: Colors.white70,
                       child: Center(
                         child: TextFormField(
                           controller: _nameController,
                           keyboardType: TextInputType.text,
                           decoration: InputDecoration(
                               hintText: "Enter your name",
                               hintStyle: const TextStyle(color: Colors.blueGrey),
                               enabledBorder: InputBorder.none,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                               prefixIcon: const Icon(Icons.person_pin,color: Colors.blueGrey,)
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),

                 SizedBox(height: 6,),
                 Padding(
                   padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                   child: ClipRRect(
                     borderRadius: const BorderRadius.all(Radius.circular(20)),
                     child: Card(
                       color: Colors.white70,
                       child: Center(
                         child: TextFormField(
                           controller: _phoneController,
                           keyboardType: TextInputType.number,
                           decoration: InputDecoration(
                               hintText: "Enter Your Phone Number",
                               hintStyle: const TextStyle(color: Colors.blueGrey),
                               enabledBorder: InputBorder.none,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                               prefixIcon: const Icon(Icons.phone,color: Colors.blueGrey,)
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),

                 SizedBox(height: 6,),

                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                   child: TextFormField(
                     controller: _dobController,
                     readOnly: true,
                     decoration: InputDecoration(
                       hintText: "Date Of Bath",
                       suffixIcon: IconButton(
                         onPressed: () => _selectDateFromPicker(context),
                         icon: Icon(Icons.calendar_today_outlined),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 6,),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                   child: TextField(
                     controller: _genderController,
                     readOnly: true,
                     decoration: InputDecoration(
                       hintText: "Choose Your Gender",
                       prefixIcon: DropdownButton<String>(
                         items: gender.map((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: new Text(value),
                             onTap: () {
                               setState(() {
                                 _genderController.text = value;
                               });
                             },
                           );
                         }).toList(),
                         onChanged: (_) {},
                       ),
                     ),
                   ),
                 ),
                  SizedBox(height: 6,),
                 Padding(
                   padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 10,),
                   child: ClipRRect(
                     borderRadius: const BorderRadius.all(Radius.circular(20)),
                     child: Card(
                       color: Colors.white70,
                       child: Center(
                         child: TextFormField(
                           controller: _ageController,
                           keyboardType: TextInputType.number,
                           decoration: InputDecoration(
                               hintText: "Enter Your Age",
                               hintStyle: const TextStyle(color: Colors.blueGrey),
                               enabledBorder: InputBorder.none,
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                               prefixIcon: const Icon(Icons.man,color: Colors.blueGrey,)
                           ),
                         ),
                       ),
                     ),
                   ),
                 ),

                 SizedBox(
                   height: 100,
                 ),

                 // elevated button
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                   child: GestureDetector(
                     onTap: () {
                       sendUserDataToDB();
                       Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));

                       EasyLoading.showToast("Profile Save succesfully done");
                     },
                     child: Container(
                       width: MediaQuery.of(context).size.width * 0.7,
                       height: 45,
                       decoration: BoxDecoration(
                         color: Colors.teal,
                         borderRadius: BorderRadius.circular(17),
                       ),
                       child: Center(
                           child: Text("Save Profile",
                               style: TextStyle(color: Colors.white, fontSize: 25))),
                     ),
                   ),
                 ),


               ],
             ),
           ),
         ),
       ),
     );
   }
 }