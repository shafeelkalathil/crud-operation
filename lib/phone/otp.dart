import 'package:crud_operation/home.dart';
import 'package:crud_operation/phone/registerphone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final String verificationId;
   Otp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpController = TextEditingController();
  Future<void> _verifyOTP() async {
    String smsCode =await _otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      // User signed in successfully
    } on FirebaseAuthException catch (e) {
      // OTP verification failed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _otpController,
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width-100,
              child: Card(
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.teal,
                child: TextButton(onPressed: () async {

                 await _verifyOTP();

                }, child: Text("Verify phone number",style: TextStyle(color: Colors.white,fontSize: 16),)),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 60,),
                InkWell(
                  onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPhone(),));
                  },
                    child: Text("Edit phone number?",style: TextStyle(color: Colors.blueAccent),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
