import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;

  TextEditingController? _dobController;
  TextEditingController? _genderController;
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
        _dobController?.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  setDatatoTextField( data){
    return SingleChildScrollView(
      child: Column(
        children: [


          SizedBox(height: 16,),
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
                    controller: _phoneController=TextEditingController(text: data["phone"]),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter your Number",
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
              controller: _dobController=TextEditingController(text: data["dob"]),
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Date  Of Birth",
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
              controller: _genderController=TextEditingController(text: data["gender"]),
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
                          _genderController!.text = value;
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
                    controller: _ageController=TextEditingController(text: data["age"]),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter your Age",
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

SizedBox(height: 100,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,),
            child: GestureDetector(
              onTap: () {
                UpdateData();
                EasyLoading.showToast("Update Profile succesfully done");
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Center(
                    child: Text("Update Profile",
                        style: TextStyle(color: Colors.white, fontSize: 25))),
              ),
            ),
          ),

        ],
      ),
    );
  }
  UpdateData(){
CollectionReference _CollectionReference=FirebaseFirestore.instance.collection("users-form-data");
return _CollectionReference.doc(FirebaseAuth.instance.currentUser?.email).update(
  {
    "name": _nameController?.text,
    "phone": _phoneController?.text,
    "age": _ageController?.text,
    "dob": _dobController?.text,
    "gender": _genderController?.text,
  }
).then( (value) {
  print("Update Succesfully");
}, );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          leading: Icon(Icons.person,color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("User Profile",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.bold)),),
         body: StreamBuilder(

           stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser?.email).snapshots(),
           builder: (BuildContext context,AsyncSnapshot snapshot) {
             var datas=snapshot.data;
             if(datas==null){
               return Center(child: CircularProgressIndicator());
             }
             return setDatatoTextField(datas);
         },),
      ),
    );
  }
}