import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commmerce_firebase/Screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Authentication/login.dart';
import 'details_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawer=GlobalKey<ScaffoldState>();
   var _firestoreinstance=FirebaseFirestore.instance;
  List<String> _carosuleImages=[];
  var _dotpogision=0;
  List _products=[];
  List _computer_products=[];
  List _hardware_products=[];

  fetchcarosuleImages()async{

    QuerySnapshot qn=await _firestoreinstance.collection("carosale-slider").get();
    setState(() {
      for(int i=0; i<qn.docs.length;i++){
        _carosuleImages.add(
          qn.docs[i]["image-path"],
        );
          print("${qn.docs[i]["image-path"]}");

      }
    });

    return qn.docs;
  }
  fetchProducts()async{
     QuerySnapshot qn=await _firestoreinstance.collection("products").get();
    setState(() {
      for(int i=0; i<qn.docs.length;i++){
        _products.add(
            {
            "product-name" : qn.docs[i]["product-name"],
            "product-description" : qn.docs[i]["product-description"],
            "product-img" : qn.docs[i]["product-img"],
            "product-price" : qn.docs[i]["product-price"],
            });


      }
    });

    return qn.docs;
  }
   fetchComputerProducts()async{
     QuerySnapshot qn=await _firestoreinstance.collection("computerproducts").get();
     setState(() {
       for(int i=0; i<qn.docs.length;i++){
         _computer_products.add(
             {
               "product-name" : qn.docs[i]["product-name"],
               "product-description" : qn.docs[i]["product-description"],
               "product-img" : qn.docs[i]["product-img"],
               "product-price" : qn.docs[i]["product-price"],
             });


       }
     });

     return qn.docs;
   }
   fetchHardwareProducts()async{
     QuerySnapshot qn=await _firestoreinstance.collection("hardwareproducts").get();
     setState(() {
       for(int i=0; i<qn.docs.length;i++){
         _hardware_products.add(
             {
               "product-name" : qn.docs[i]["product-name"],
               "product-description" : qn.docs[i]["product-description"],
               "product-img" : qn.docs[i]["product-img"],
               "product-price" : qn.docs[i]["product-price"],
             });


       }
     });

     return qn.docs;
   }

  @override
  void initState() {
fetchcarosuleImages();
fetchProducts();
fetchComputerProducts();
fetchHardwareProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawer,
backgroundColor: Colors.white70,
drawer: Drawer(
   width: MediaQuery.of(context).size.width*0.8,

  child: Container(
    height: double.infinity,
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
         children: [

           DrawerHeader(child:  Container(

            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.blue,
            ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Align(
                     alignment: Alignment.topRight,
                     child: GestureDetector(
                       onTap: () {
                         Navigator.pop(context);
                       },
                       child: Container(
                         height: 30,
                         width: 30,
                         decoration: BoxDecoration(
                             color:Colors.white,
                             shape: BoxShape.circle
                         ),
                         child: Center(child: Icon(Icons.cancel_rounded,color: Colors.teal)),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: RichText(
                     text: TextSpan(
                       text: '',
                       style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                       children:   <TextSpan>[
                         TextSpan(text:"${FirebaseAuth.instance.currentUser?.email}",style: GoogleFonts.cabin(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                       ],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: RichText(
                     text: TextSpan(
                       text: 'Id : ',
                       style: TextStyle(color: Colors.white),
                       children:   <TextSpan>[
                         TextSpan(text:"${FirebaseAuth.instance.currentUser?.uid}",style: GoogleFonts.actor(color: Colors.white,fontSize: 13)),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           )),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.list_alt,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("My Orders",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(

                 leading: Icon(Icons.add_location_alt_outlined,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("Manage Address",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),
           GestureDetector(
             onTap: () {
               FirebaseAuth.instance.signOut();
               EasyLoading.showSuccess("Log Out Successful Done");
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 5.0),
               child:   Card(

                 elevation: 10,

                 child:   ListTile(



                   leading: Icon(Icons.logout_sharp,color: Colors.teal),



                   trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                   title: Text("Log Out",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



                 ),

               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.wallet,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("My Wallet",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.list_alt,color: Colors.teal),



                 trailing: Icon(Icons.percent_outlined,color: Colors.red),



                 title: Text("Your Promo Code",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
            SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.lock_clock_outlined,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("Change Password",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.headset_sharp,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("Customer Support",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.more_horiz,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("About Us",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 5.0),
             child:   Card(

               elevation: 10,

               child:   ListTile(



                 leading: Icon(Icons.settings,color: Colors.teal),



                 trailing: Icon(Icons.arrow_forward_ios,color: Colors.red),



                 title: Text("Settings",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),



               ),

             ),
           ),
           SizedBox(height: 5,),


         ],
      ),
    ),

  ),
),
appBar: AppBar(
  leading: IconButton(onPressed: () {
    _drawer.currentState?.openDrawer();
  }, icon: const Icon(Icons.drag_indicator,color: Colors.black,)),
  backgroundColor: Colors.white70,
  elevation: 0,
  title:  Text("National Computers Ltd.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1)),
  actions: [
    IconButton(onPressed: () {
      FirebaseAuth.instance.signOut();
      EasyLoading.showSuccess("Log Out Successful Done");
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }, icon: Icon(Icons.logout,color: Colors.black,)),
   ],
),

       body: SingleChildScrollView(
         child: SafeArea(
           child: Column(
             children: [
               SizedBox(height: 10,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Container(
                     height: 50,
                     width: MediaQuery.of(context).size.width/1.3,
                     child: Card(
                       elevation: 5,
                       color: Colors.white,
                       child: TextFormField(
                         readOnly: true,
                         onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchScreen(),)),
                         decoration:   InputDecoration(
                           hintText: "Search Accessories..",
                           hintStyle: const TextStyle(color: Colors.blueGrey),
                           enabledBorder: InputBorder.none,
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                           prefixIcon: const Icon(Icons.search_outlined,color: Colors.teal,),
                         ),
                       ),
                     ),
                   ),
                   Container(
                     height: 40,width: 40,
                     decoration: BoxDecoration(
                         color: Colors.teal,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: Icon(Icons.filter_alt_outlined,color: Colors.white),
                   )
                 ],
               ),

               SizedBox(height: 10,),
SizedBox(height: 20,),
               CarouselSlider(
                   items: _carosuleImages.map((e) => Padding(
                 padding: const EdgeInsets.only( left: 4.0,right: 4.0),
                 child: Container(
                   height: 180,
                   width: MediaQuery.of(context).size.width*0.9,
                   decoration: BoxDecoration(
                     color: Colors.black,
                     borderRadius: BorderRadius.circular(15),
                       // image: DecorationImage(
                       //
                       //     image: NetworkImage(e,),
                       //     fit: BoxFit.fitWidth
                       // )
                   ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.network(e,

                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill
                      ),
                    ),
                 ),
               )).toList(), options: CarouselOptions(

                 autoPlay: false,
                 enlargeCenterPage: true,
                 viewportFraction: 0.9,
                 enlargeStrategy:CenterPageEnlargeStrategy.height,
                 onPageChanged: (index, reason) {
                   setState(() {
                     _dotpogision=index;
                   });
                 },
               )),
               SizedBox(height: 10,),
               DotsIndicator(
                 dotsCount: _carosuleImages.length==0?1:_carosuleImages.length,
                 position: int.parse(_dotpogision.toString()),
                 decorator: DotsDecorator(

                    activeColor: Colors.orange,
                       color: Colors.red,
                   spacing: EdgeInsets.all(2),
                   activeSize: Size(10, 10),
                   size: Size(6, 6),

                 ),
               ),
               SizedBox(height: 17,),
               ListTile(
                 title: Text("Mobile Accessories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,letterSpacing: 2)),
                 trailing: Text("See All",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue,letterSpacing: 2)),

               ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: _products[index]),)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                          height: 200,
                          width: 160,
                          decoration: BoxDecoration(
                              color:  Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )
                          ),
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
     ClipRRect(
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
       child: Image.network("${_products[index]["product-img"][0]}",
           fit: BoxFit.fitWidth,
           height: 130,
           width: 160,),
     ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${_products[index]["product-name"]}",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Text("\$${_products[index]["product-price"]}",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                                    SizedBox(width: 20,),
                                    Text("11.00%",style: GoogleFonts.pacifico(color: Colors.blueGrey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  ),
                ),
               SizedBox(height: 10,),
               ListTile(
                 title: Text("Computer Accessories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,letterSpacing: 2)),
                 trailing: Text("See All",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue,letterSpacing: 2)),

               ),
               SizedBox(
                 height: 200,
                 child: ListView.builder(
                   primary: false,
                   shrinkWrap: true,
                   itemCount: _computer_products.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (BuildContext context, int index) {
                     return GestureDetector(
                       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: _computer_products[index]),)),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 6.0),
                         child: Container(
                           height: 200,
                           width: 160,
                           decoration: BoxDecoration(
                               color:  Colors.white,
                               border: Border.all(color: Colors.black),
                               borderRadius: BorderRadius.only(
                                 bottomLeft: Radius.circular(20),
                                 bottomRight: Radius.circular(20),
                                 topLeft: Radius.circular(20),
                               )
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               ClipRRect(
                                 borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(20),
                                 ),
                                 child: Image.network("${_computer_products[index]["product-img"][0]}",
                                   fit: BoxFit.fitWidth,
                                   height: 130,
                                   width: 160,),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text("${_computer_products[index]["product-name"]}",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, )),
                               ),
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                 child: Row(
                                   children: [
                                     Text("\$${_computer_products[index]["product-price"]}",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                                     SizedBox(width: 20,),
                                     Text("21.00%",style: GoogleFonts.aBeeZee(color: Colors.blueGrey)),

                                   ],
                                 ),
                               ),

                             ],
                           ),
                         ),
                       ),
                     );
                   },

                 ),
               ),
SizedBox(height: 10,),
               ListTile(
                 title: Text("Hardware Accessories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,letterSpacing: 2)),
                 trailing: Text("See All",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue,letterSpacing: 2)),

               ),
SizedBox(

  width: double.infinity,
  child:   GridView.builder(

    primary: false,

    shrinkWrap: true,

     clipBehavior: Clip.none,

     itemCount: _hardware_products.length,

    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

      crossAxisCount: 2,

      mainAxisSpacing: 8,

      // crossAxisSpacing: 8,

      childAspectRatio: 1,

    ),

    itemBuilder: (BuildContext context, int index) {

  return GestureDetector(

    onTap: () {

    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: _hardware_products[index]),));

    },

    child:   Container(
margin: EdgeInsets.only(right: 4,left: 4),
    height: 170,

    width: 175,

    decoration: BoxDecoration(

      color:  Colors.white,

      border: Border.all(color: Colors.black),

      borderRadius:BorderRadius.only(

            bottomRight: Radius.circular(30),

            topLeft : Radius.circular(30),

      ),

    ),

    child: SingleChildScrollView(

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

        ClipRRect(

             borderRadius:BorderRadius.only(

                topLeft : Radius.circular(30),

              ),

              child: Image.network("${_hardware_products[index]["product-img"][0]}",

                fit: BoxFit.fitWidth,

                height: 120,

               width: 180,

              ),

            ),

            Padding(

              padding: const EdgeInsets.all(8.0),

             child: Text("${_hardware_products[index]["product-name"]}",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, )),

            ),



            Padding(

              padding: const EdgeInsets.all(8.0),

              child: RichText(

                text: TextSpan(

                  text: "",

                  style: TextStyle(color: Colors.deepOrange),

                  children:   <TextSpan>[

                    TextSpan(text: "\$${_hardware_products[index]["product-price"]}",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),

                    TextSpan(text: "    6.00%",style: TextStyle(color: Colors.blueGrey)),

                  ],

                ),

              ),

            )

        ],





      ),

    ),







    ),

  );



  },),
),

               SizedBox(height: 20,),

             ],
           ),
         ),
       ),
    );
  }
}
