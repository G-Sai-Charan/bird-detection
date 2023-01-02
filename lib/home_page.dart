import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "img/signup.png"
                    ),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
              children: [
                SizedBox(height: h*0.15,),
                CircleAvatar(
                  backgroundColor: Colors.white70,
                  radius: 60,
                  backgroundImage: AssetImage(
                      "img/profile1.png"
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: w*0.12),
          RichText(text: TextSpan(
              text:"Upload the image here",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
          )),
          SizedBox(height: w*0.10),
          Container(
            width: w*0.5,
            height: h*0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: AssetImage(
                        "img/loginbtn.png"
                    ),
                    fit: BoxFit.cover
                )
            ),
            child: Center(
              child: Text(
                "Upload",
                style:TextStyle(
                    fontSize:36,
                    fontWeight: FontWeight.bold,
                    color:Colors.white
                ),
              ),
            ),
          ),
          RichText(
              text:TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account? Click Here",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey[500]
                  )
              )
          ),
        ],
      ),
    );
  }
}
