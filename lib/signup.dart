import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  final TextEditingController _name=TextEditingController();
  final TextEditingController _email=TextEditingController();
 final TextEditingController _password=TextEditingController();
 final TextEditingController _confirmpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://img.lovepik.com/background/20211030/medium/lovepik-background-of-science-and-technology-mobile-image_400421567.jpg"),
                fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  children: [
                    SizedBox(height: 100,),
                    Row(
                      children: [
                        SizedBox(width: 40,),
                        Text("Create Account",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Container(
                      width: MediaQuery.of(context).size.width-76,
                      child: Card(
                        elevation: 10,
                        child: TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "FULL NAME",
                              prefixIcon: Icon(Icons.person)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width-76,
                      child: Card(
                        elevation: 10,
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Enter email",
                              prefixIcon: Icon(Icons.email)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width-76,
                      child: Card(
                        elevation: 10,
                        child: TextFormField(
                             controller: _password,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "PASSWORD",
                              prefixIcon: Icon(Icons.lock),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width-76,
                      child: Card(
                        elevation: 10,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _confirmpassword,
                          decoration: InputDecoration(
                              labelText: "CONFIRM PASSWORD ",
                              prefixIcon: Icon(Icons.lock)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: InkWell(
                            onTap: () async {
                              if(_name.text!=''&&_email.text!=''&&_password.text!=''&&_confirmpassword.text!=''){
                                try {
                                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: _email.text.toLowerCase().trim(),
                                    password: _password.text,
                                  ).then((value) {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                        return Login(pswd: '', phone: '');
                                    },));
                                  } );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password'||_password.text!=_confirmpassword.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Password is too weak or incorrect confirm password.'),
                                        ));
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('The account already exists for that email.'),

                                        ));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Invalid form.'),

                                    ));
                              }
                             //  SharedPreferences prefs = await SharedPreferences.getInstance();
                             //  prefs.setString('password',_password.text );
                             //  prefs.setString('phone',_email.text );
                             //  var phone= prefs.getString('phone');
                             // var password= prefs.getString('password');
                             // print(password);
                             //  print(_email.text);
                             //  if(_password.text==_confirmpassword.text){
                             //      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                             //        return Login(pswd:password.toString() ,phone: phone.toString(),);
                             //      },));
                             //  }else{
                             //    ScaffoldMessenger.of(context).showSnackBar(
                             //        SnackBar(
                             //          content: Text('Incorrect password or confirmpassword'),
                             //
                             //        ));
                             //  }
                            },
                            child: Container(
                              height: 60,
                              width: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  gradient: LinearGradient(
                                      colors: [Colors.white,Colors.blue]
                                  )

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 10,),
                                  Icon(Icons.arrow_forward,color: Colors.white,size: 25,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don\'t have an account?",style: TextStyle(color: Colors.white),),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(pswd:'',phone: '',),));
                    }, child: Text("Sign in",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
