import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, this.product});
  final product;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {



  var _firestoreinstance=FirebaseFirestore.instance;
  List _hardware_products=[];
  List _computer_products=[];
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


  bool fav_or_notFav=false;
  Future<void> addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _reference =
        FirebaseFirestore.instance.collection("users-cart-item");
    return _reference.doc(currentUser!.email).collection("items").doc().set({
      "name": widget.product["product-name"],
      "price": widget.product["product-price"],
      "images": widget.product["product-img"],
    }).then(
      (value) {
        print("Added to cart Succesful");
      },
    );
  }

  Future<void> addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _reference =
        FirebaseFirestore.instance.collection("users-favourite-item");
    return _reference.doc(currentUser!.email).collection("favouriteitems").doc().set({
      "name": widget.product["product-name"],
      "price": widget.product["product-price"],
      "images": widget.product["product-img"],
    }).then(
      (value) {
        print("Added to Favourite Succesful");
      },
    );
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHardwareProducts();
    fetchComputerProducts();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,),
        child: GestureDetector(
          onTap: () {
            addToCart();
            EasyLoading.showToast("Add to cart is succesfully done");
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
                child: Text("Add to cart",
                    style: TextStyle(color: Colors.white, fontSize: 25))),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.teal),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        )
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   width: 50,
                    //   child: StreamBuilder(
                    //     stream: FirebaseFirestore.instance
                    //         .collection("users-favourite-item")
                    //         .doc(FirebaseAuth.instance.currentUser?.email)
                    //         .collection("items")
                    //         .where("name",isEqualTo: widget.product["product-name"]).snapshots(),
                    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>  snapshot) {
                    //       if(snapshot.data != null){
                    //         return Text("");
                    //       }
                    //       return Container(
                    //           height: 50,
                    //           width: 50,
                    //           decoration: BoxDecoration(
                    //               shape: BoxShape.circle, color: Colors.teal),
                    //           child: Center(
                    //             child: IconButton(
                    //               onPressed: () {
                    //                 addToFavourite();
                    //                 // snapshot.data?.docs.length==0?  addToFavourite(): EasyLoading.showToast("Already Added");
                    //               EasyLoading.showToast("Add to Favourite succesfully done");
                    //               },
                    //               icon:snapshot.data?.docs.length==0
                    //                   ?
                    //               Icon(Icons.favorite, color: Colors.white)
                    //               :
                    //               Icon(Icons.favorite, color: Colors.deepOrange),
                    //             ),
                    //           ));
                    //   },
                    //
                    //   ),
                    // ),

                    // Container(
                    //     height: 50,
                    //     width: 50,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle, color: Colors.teal),
                    //     child: Center(
                    //       child: IconButton(
                    //         onPressed: () {
                    //             addToFavourite();
                    //             EasyLoading.showToast("Add to Favourite succesfully done");
                    //         },
                    //         icon:fav_or_notFav==false ?
                    //         Icon(Icons.favorite, color: Colors.white)
                    //             :
                    //         Icon(Icons.favorite, color: Colors.deepOrange),
                    //       ),
                    //     ))

                    GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   addToFavourite();
                        // });
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.teal),
                          child: Center(
                            child: fav_or_notFav==false?
                            IconButton(onPressed: () {
                              addToFavourite();
                              EasyLoading.showSuccess("Add to Favourite succesfully done");
                             setState(() {
                               fav_or_notFav=true;
                             });
                            }, icon: Icon(Icons.favorite,color: Colors.white,))
                            :
                            IconButton(onPressed: () {
                              setState(() {
                                fav_or_notFav=false;

                              });
                            }, icon: Icon(Icons.favorite,color: Colors.orange,)),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AspectRatio(
                aspectRatio: 1.8,
                child: CarouselSlider(
                    items: widget.product["product-img"]
                        .map<Widget>((e) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: Container(
                                height: 230,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(10),
                                ),
                                child: Card(
                                  elevation: 20,
                                  child: Image.network(e,
                                    height: 230,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),

                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: GoogleFonts.alata(color: Colors.black),
                    children:   <TextSpan>[
                      TextSpan(text: 'Product Name : ', style: TextStyle(fontWeight: FontWeight.normal,color: Colors.red)),
                      TextSpan(text: widget.product["product-name"],style: GoogleFonts.acme(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 1,fontSize: 20)),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: GoogleFonts.alata(color: Colors.black),
                    children:   <TextSpan>[
                      TextSpan(text: 'Product Price : ', style: TextStyle(fontWeight: FontWeight.normal,color: Colors.red)),
                      TextSpan(text: "\$${widget.product["product-price"].toString()}",style: GoogleFonts.pacifico(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 2,fontSize: 20)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: GoogleFonts.alata(color: Colors.black),
                    children:   <TextSpan>[
                      TextSpan(text: 'Product Description : ', style: TextStyle(fontWeight: FontWeight.normal,color: Colors.red)),
                      TextSpan(text: widget.product["product-description"],style: GoogleFonts.actor(color: Colors.black,letterSpacing: 1,)),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),



              ListTile(
                leading: Icon(Icons.horizontal_split_outlined),
                title: Text("Related Products",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20,letterSpacing: 2)),
                trailing:  Icon(Icons.arrow_downward,color: Colors.black),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _hardware_products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: _hardware_products[index]),)),
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
                           child: SingleChildScrollView(
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                  ),
                                  child: Image.network("${_hardware_products[index]["product-img"][0]}",
                                    fit: BoxFit.fitWidth,
                                    height: 130,
                                    width: 160,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${_hardware_products[index]["product-name"]}",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold, )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Text("\$${_hardware_products[index]["product-price"]}",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                                      SizedBox(width: 20,),
                                      Text("11.00%",style: GoogleFonts.pacifico(color: Colors.blueGrey)),
                                    ],
                                  ),
                                ),

                              ],
                          ),
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

            ],
          ),
        ),
      ),
    );
  }
}
