import 'package:bird_detection/auth_controller.dart';
import 'package:bird_detection/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'background-image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(
      children:[
        BackgroundImage(
          image: 'img/login.png'
        ),
        Scaffold(
      backgroundColor: Colors.transparent,
    body: SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //   width: w,
          //   height: h*0.3,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //         "img/loginimg.png"
          //       ),
          //       fit: BoxFit.cover
          //     )
          //   ),
          // ),
          SizedBox(height: 200),
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style:TextStyle(
                    fontSize:60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in to your account",
                  style:TextStyle(
                      fontSize:20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 10,
                    //     spreadRadius: 7,
                    //     offset: Offset(1,1),
                    //     color: Colors.grey.withOpacity(0.5)
                    //   )
                    // ]
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                        fillColor: Colors.white30,
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                        ),
                        prefixIcon: Icon(Icons.email,color: Colors.redAccent,),
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
                      //       blurRadius: 10,
                      //       spreadRadius: 7,
                      //       offset: Offset(1,1),
                      //       color: Colors.blueGrey.withOpacity(0.5)
                      //   )
                      // ]
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white30,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white,
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
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(20)
                        // )
                    ),
                  ),
                ),
                SizedBox(height: w*0.08),
                Row(
                  children: [
                    Expanded(child: Container(),),
                    Text(
                      "Forgot password?  ",
                      style:TextStyle(
                          fontSize:17,
                          color: Colors.white70
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: (){
              AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
            },
            child: Container(
              width: w*0.4,
              height: h*0.07,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(30),
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //         "img/O.jpeg"
                  //     ),
                  //     fit: BoxFit.cover
                  // )

              ),
              child: Center(
                child: Text(
                  "Sign in",
                  style:TextStyle(
                      fontSize:25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          RichText(text: TextSpan(
            text:"Don\'t have an account?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
            children: [
              TextSpan(
              text:" Click Here!",
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
              )
            ]
          ))
        ],
      ),
    ),
    )
    ],
    );
  }
}
