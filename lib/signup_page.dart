import 'package:bird_detection/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'background-image.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    List images=[
      "g.png",
      "t.png",
      "f.png"
    ];
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        BackgroundImage(
            image: 'img/p.jpg'
        ),
      Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200),
            Text(
              "Create new account",
              style:TextStyle(
                fontSize:30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          //   Container(
          //     width: w,
          //     height: h*0.3,
          //     decoration: BoxDecoration(
          //         image: DecorationImage(
          //             image: AssetImage(
          //                 "img/signup.png"
          //             ),
          //             fit: BoxFit.cover
          //         )
          //     ),
          //     child: Column(
          //       children: [
          //         SizedBox(height: h*0.15,),
          //         CircleAvatar(
          //           backgroundColor: Colors.white70,
          //           radius: 60,
          //           backgroundImage: AssetImage(
          //             "img/profile1.png"
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //       blurRadius: 12,
                        //       spreadRadius: 7,
                        //       offset: Offset(1,1),
                        //       color: Colors.pinkAccent.withOpacity(0.5)
                        //   )
                        // ]
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white30,
                        hintText: "Your email id",
                          hintStyle: TextStyle(color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                          prefixIcon: Icon(Icons.email,color: Colors.deepOrange,),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.white60,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        // boxShadow: [
                        //   BoxShadow(
                        //       blurRadius: 12,
                        //       spreadRadius: 7,
                        //       offset: Offset(1,1),
                        //       color: Colors.pinkAccent.withOpacity(0.5)
                        //   )
                        // ]
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white30,
                          hintText: "Your password",
                          hintStyle: TextStyle(color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                          prefixIcon: Icon(Icons.lock,color: Colors.pinkAccent,),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.white60,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0
                              )
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: w*0.10),
            GestureDetector(
              onTap: (){
                AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());

              },
              child: Container(
                width: w*0.4,
                height: h*0.07,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30),
                    // image: DecorationImage(
                    //     image: AssetImage(
                    //         "img/P.jpeg"
                    //     ),
                    //     fit: BoxFit.cover
                    // )
                ),
                child: Center(
                  child: Text(
                    "Sign up",
                    style:TextStyle(
                        fontSize:25,
                        fontWeight: FontWeight.bold,
                        color:Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:w*0.08),
            RichText(text: TextSpan(
                text:"Have an account?",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 25,
                    fontWeight: FontWeight.w500
                ),
                children: [
                  TextSpan(
                      text:"  Click Here!",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  )
                ]
            )),
            // RichText(
            //     text:TextSpan(
            //       recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
            //       text: "Have an account? Click Here",
            //       style: TextStyle(
            //         fontSize: 22,
            //         color: Colors.grey[500]
            //       )
            //     )
            // ),
            SizedBox(height: w*0.12),
            RichText(text: TextSpan(
                text:"or you can sign in with",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 22,
                )
            )),
            Wrap(
              children: List<Widget>.generate(
                3,(index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[500],
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "img/"+images[index]
                      ),
                    ),
                  ),
                );
              }
              ),
            )
          ],
        ),
      ),
    )
    ],
    );
  }
}
