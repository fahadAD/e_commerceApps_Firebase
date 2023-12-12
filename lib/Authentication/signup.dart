import 'package:e_commmerce_firebase/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Screens/user_inputform_screen.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obsucre=true;
  GlobalKey<FormState> _form=GlobalKey<FormState>();
  TextEditingController signupEmailcontroller=TextEditingController();
  TextEditingController signupPasswordcontroller=TextEditingController();
Future<void> signUPFun()async {
  if(signupEmailcontroller.text != '' &&  signupPasswordcontroller.text != ''){
    if(signupEmailcontroller.text.contains("@") && signupEmailcontroller.text.contains(".com")){
      try{
        EasyLoading.show(status: "Loding..");
        var auth=FirebaseAuth.instance;
        UserCredential user=await auth.createUserWithEmailAndPassword(email: signupEmailcontroller.text, password: signupPasswordcontroller.text);
        if(user.user != null){
          EasyLoading.showSuccess("Signup done");
          Navigator.pop(context);
        }else{
          EasyLoading.showError("Something is wrong");
        }
      }on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.showError('The password provided is too weak.');
        }
        else if (e.code == 'email-already-in-use') {
          EasyLoading.showError('The account already exists for that email.');
        }
      }catch(e){
        EasyLoading.showError(e.toString());

      }
    }else{
      EasyLoading.showError("Enter a valid email");
    }
  }else{
    EasyLoading.showError("Required email & password");
  }
}

  Future<void> GoogleSign()async{

    EasyLoading.show(status: "Loding");

    final GoogleSignInAccount? _googleSignInAccount_user=await GoogleSignIn().signIn();
    final GoogleSignInAuthentication?  _googleauth=await _googleSignInAccount_user?.authentication;

    final _crediental=GoogleAuthProvider.credential(accessToken: _googleauth?.accessToken, idToken: _googleauth?.idToken);
    UserCredential users= await FirebaseAuth.instance.signInWithCredential(_crediental);

    if(users.user != null){
      EasyLoading.showSuccess("Google signup sussessful done ");
      Navigator.push(context, MaterialPageRoute( builder: (context) =>  UserForm()));
    }else{
      EasyLoading.showError("Something is wrong");
    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    signupPasswordcontroller.dispose();
    signupEmailcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              SizedBox(
                height: 120,
                child: Container(color: Colors.teal,
                  child:Column(
                    children: [
                      SizedBox(height: 40,),
                      ListTile(
                        title: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),

                      ),
                    ],
                  ),),
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white
                ),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      ListTile(
                        title: Text("Welcome",style: GoogleFonts.pacifico(fontWeight: FontWeight.w400,color: Colors.teal,fontSize: 25)),
                        subtitle: Text("Glad to see you sir",style: GoogleFonts.actor(color: Colors.blueGrey),),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: TextFormField(
                      //     controller: loginEmailcontroller,
                      //     decoration: InputDecoration(
                      //         labelText: "Email",
                      //         border: OutlineInputBorder()),
                      //   ),
                      // ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(
                            height: 40,width: 40,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.person_pin,color: Colors.white),
                          ),
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Center(
                                child: TextFormField(
validator: (value) {
  if(value!.isEmpty){
    return "Required Name";
  }return null;
},
                                  decoration:   InputDecoration(
                                    hintText: "  Registered Your Name",
                                    hintStyle: const TextStyle(color: Colors.blueGrey),
                                    enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(
                            height: 40,width: 40,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.attach_email_outlined,color: Colors.white),
                          ),
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Center(
                                child: TextFormField(

                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Required Email";
                                    }return null;
                                  },
                                  controller: signupEmailcontroller,
                                  decoration:   InputDecoration(
                                    hintText: "  Registered Your Email",
                                    hintStyle: const TextStyle(color: Colors.blueGrey),
                                    enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(
                            height: 40,width: 40,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.lock_outlined,color: Colors.white),
                          ),
                          Container(
                            height: 55,
                            width: MediaQuery.of(context).size.width/1.3,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Center(
                                child: TextFormField(
obscureText: _obsucre,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Required Password";
                                    }return null;
                                  },
keyboardType: TextInputType.number,
                                  controller: signupPasswordcontroller,
                                  decoration:   InputDecoration(

                                    suffixIcon:_obsucre== false? GestureDetector(
                                        onTap: () {
                                          _obsucre=true;
                                        },
                                        child: Icon(Icons.remove_red_eye,color: Colors.black)) : GestureDetector(
                                        onTap: () {
                                          _obsucre=false;
                                        },
                                        child: Icon(Icons.visibility_off,color: Colors.black)),
                                    hintText: "  Registered Your Password",
                                    hintStyle: const TextStyle(color: Colors.blueGrey),
                                    enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                        child: GestureDetector(
                          onTap: () {
                            if(_form.currentState!.validate()){
                              signUPFun();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                                child: Text("SIGN UP",
                                    style: TextStyle(color: Colors.white, fontSize: 20))),
                          ),
                        ),
                      ),


                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

                        },
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(color: Colors.black,),
                            children:   <TextSpan>[
                              TextSpan(text: "Do you have an account? ", style: GoogleFonts.acme(fontWeight: FontWeight.normal,color: Colors.black)),
                              TextSpan(text: ' Log In',style: GoogleFonts.aBeeZee(color:Colors.blue,fontWeight: FontWeight.bold,fontSize: 17 )),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),

                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const Divider(
                              color: Colors.blueGrey,
                              thickness: 2,
                              endIndent: 20,
                              indent: 20),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Center(
                                child: Text("OR",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              EasyLoading.showSuccess("Login Succesfuliy Done ");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserForm()));
                            },
                            child: CircleAvatar(
                              radius: 17,
                              backgroundImage: AssetImage("images/apple.webp"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              EasyLoading.showSuccess("Login Succesfuliy Done ");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserForm()));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              backgroundImage: AssetImage("images/facebook.png"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GoogleSign();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              backgroundImage: AssetImage("images/google.png"),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
// SizedBox(height: 30,),
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20),
//   child: TextFormField(
//     controller: signupEmailcontroller,
//     decoration: InputDecoration(
//         labelText: "Email",
//         border: OutlineInputBorder()),
//   ),
// ),SizedBox(height: 20,),
//
// SizedBox(height: 30,),
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20),
//   child: TextFormField(
//     controller: signupPasswordcontroller,
//     decoration: InputDecoration(
//         labelText: "Password",
//         border: OutlineInputBorder()),
//   ),
// ),SizedBox(height: 20,),
//
// ElevatedButton(onPressed: () async {
//   signUPFun();
// }, child: Text("Sign Up")),
// SizedBox(height: 20,),
//
// ElevatedButton(onPressed: () async {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
// }, child: Text("Log In")),