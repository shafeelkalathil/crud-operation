import 'package:crud_operation/phone/registerphone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SmsVerificationPage extends StatefulWidget {
  final String phone;
  final String verificationId;
   SmsVerificationPage({Key? key, required this.phone, required this.verificationId}) : super(key: key);

  @override
  State<SmsVerificationPage> createState() => _SmsVerificationPageState();
}

class _SmsVerificationPageState extends State<SmsVerificationPage>
    with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  int levelClock = 2 * 60;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _animationController!.forward();

    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

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

  Future<void> _sendVerificationCode(BuildContext context, String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SmsVerificationPage(verificationId: verificationId, phone: phoneNumber,),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F4FD),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  Text("Verification"),
                  Text(
                    "We sent you a SMS Code",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "On number: ${widget.phone}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  InkWell(onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPhone(),));
                  }, child: Text("Edit phone number?",style: TextStyle(color: Colors.blueAccent),))
                ],
              ),
            ),
            Center(
              child: PinFieldAutoFill(
                controller: _otpController,
                codeLength: 6,
                autoFocus: true,
                decoration: UnderlineDecoration(
                  lineHeight: 2,
                  lineStrokeCap: StrokeCap.square,
                  bgColorBuilder: PinListenColorBuilder(
                      Colors.green.shade200, Colors.grey.shade200),
                  colorBuilder: const FixedColorBuilder(Colors.transparent),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Resend code after: "),
                Countdown(
                  animation: StepTween(
                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_animationController!),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 56,
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                //?  use this code to get sms signature for your app
                // final String signature = await SmsAutoFill().getAppSignature;
                // print("Signature: $signature");
                _sendVerificationCode(context,widget.phone);
                _animationController!.reset();
                _animationController!.forward();
              },
              child: const Text("Resend"),
            ),
          ),
          SizedBox(
            height: 56,
            width: 200,
            child: ElevatedButton(
              onPressed:  () {
                //Confirm and Navigate to Home Page
                _verifyOTP();
              } ,
              child:  Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}