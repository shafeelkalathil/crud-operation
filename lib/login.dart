
import 'package:crud_operation/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  final String pswd;
  final String phone;
   Login({Key? key, required this.pswd, required this.phone}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController password=TextEditingController();
  final TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1517502166878-35c93a0072f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80"),
          fit: BoxFit.cover)
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             SizedBox(height: 1,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.grey[850]),),
                        ),
                      ],
                    ),
                    SizedBox(height: 7,),
                    Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("Please sign in to continue.",style: TextStyle(fontSize: 24,color: Colors.grey[800]),),
                        ),
                      ],
                    ),
                    SizedBox(height: 60,),
                    Container(
                      width: MediaQuery.of(context).size.width-76,
                      child: Column(
                        children: [
                          Card(
                            elevation: 8,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                             controller: email,
                                decoration: InputDecoration(
                                hintText: "email",
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                 borderSide: BorderSide.none
                                  )
                                ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Card(
                            elevation: 8,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                                controller: password,
                              decoration: InputDecoration(
                                  hintText: "password",
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                  )
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: InkWell(
                            onTap: () async {
                              try {
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                ).then((value) {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                    return Home();
                                  },));
                                });
                              }  on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('No user found for that email.'),

                                    ),
                                  );
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Wrong password provided for that user.'),

                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: 60,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                               gradient: LinearGradient(
                                 colors: [Colors.white,Colors.black]
                               )

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.arrow_forward,color: Colors.white,size: 25,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )

                  ],

                ),
              ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Don\'t have an account?",style: TextStyle(color: Colors.white),),
                 TextButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp(),));
                 }, child: Text("Sign up",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 15),))
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
