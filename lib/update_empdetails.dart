import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class updateEmpDetails extends StatefulWidget {
  final String empName;
  final String empPos;
  final String empID;
  final String empPhone;
  final String empEmail;
  final String id;

   updateEmpDetails({Key? key,required this.empName,
     required this.empPos,
     required this.empID,
     required this.empPhone,
     required this.empEmail, required this.id}) : super(key: key);
@override
  State<updateEmpDetails> createState() => _updateEmpDetailsState();
}

class _updateEmpDetailsState extends State<updateEmpDetails> {

  TextEditingController name =TextEditingController();
  TextEditingController pos =TextEditingController();
  TextEditingController id =TextEditingController();
  TextEditingController phone =TextEditingController();
  TextEditingController email =TextEditingController();
  @override
 void initState() {

    initForm();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Update  Employee Details",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(20)
                    ),

                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: pos,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: id,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(

                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
               controller: email,
                  decoration: InputDecoration(


                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(20)
                    ),

                  ),
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){
                showDialog(context: context,
                  builder: (context) {

                  FirebaseFirestore.instance.collection('employees').doc(widget.id).update({
                    "empName":name.text,
                    "empPos":pos.text,
                    "empId":id.text,
                    "empPhone":phone.text,
                    "empEmail":email.text
                  });

                  return AlertDialog(
                      content: Text("Update Employee Details  Successfully",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
actions: [
  ElevatedButton(onPressed: (){
    Navigator.pop(context);
    Navigator.pop(context);
  }, child: Text('Ok'))
],
                    );
                  },);
              }, child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
  void initForm(){
    name.text = widget.empName;
    pos.text = widget.empPos;
    id.text = widget.empID;
    phone.text = widget.empPhone;
    email.text = widget.empEmail;


  }
}
