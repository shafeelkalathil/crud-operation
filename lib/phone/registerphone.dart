import 'package:crud_operation/phone/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({Key? key}) : super(key: key);

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}
Future<void> _sendVerificationCode(BuildContext context, String phoneNumber) async {
  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Otp(verificationId: verificationId),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}


class _RegisterPhoneState extends State<RegisterPhone> {
  TextEditingController phone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Phone Verification",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("We need to register your phone before getting",style: TextStyle(fontSize: 16)),
            Text("started !",style: TextStyle(fontSize: 16)),
            SizedBox(height: 10,),
            TextFormField(
               controller: phone,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width-100,
              child: Card(
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.teal,
                child: TextButton(onPressed:()=> _sendVerificationCode(context, phone.text.trim()),
                    child: Text("Send otp",style: TextStyle(color: Colors.white,fontSize: 16),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
