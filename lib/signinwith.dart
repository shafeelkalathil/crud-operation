
import 'package:crud_operation/home.dart';
import 'package:crud_operation/login.dart';
import 'package:crud_operation/phone/registerphone.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';




class SignInWith extends StatefulWidget {
   SignInWith({Key? key}) : super(key: key);

  @override
  State<SignInWith> createState() => _SignInWithState();
}


final GoogleSignIn  googleSignIn = GoogleSignIn();


class _SignInWithState extends State<SignInWith> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width-100,
                child: Card(
                  child: TextButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return Login(phone: '',pswd: '',);
                    },));
                  },child: Row(
                    children: [
                      SizedBox(width: 70,),
                      Icon(Icons.email),
                      SizedBox(width: 10,),
                      Text("SIGN IN WITH EMAIL"),
                    ],
                  ),),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width-100,
                child: Card(
                  child: TextButton(
                    onPressed: () async {
                      await googleSignIn.signIn();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                        return Home();
                      },));
                    },
                    child: Row(
                    children: [
                      SizedBox(width: 60,),
                      Image(image: NetworkImage("https://services.google.com/fh/files/misc/google_g_icon_download.png")),
                      SizedBox(width: 10,),
                      Text("SIGN IN WITH GOOGLE"),
                    ],
                  ),),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width-100,
                child: Card(
                  child: TextButton(
                    onPressed: ()  {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                           return RegisterPhone();
                         },));
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 60,),
                         Icon(Icons.call),
                        SizedBox(width: 10,),
                        Text("SIGN IN WITH PHONE"),
                      ],
                    ),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
