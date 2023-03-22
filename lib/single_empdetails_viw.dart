import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleEmpDetailsView extends StatefulWidget {

  final String? id;

   SingleEmpDetailsView({Key? key,required this.id,}) : super(key: key);

  @override
  State<SingleEmpDetailsView> createState() => _SingleEmpDetailsViewState();
}

class _SingleEmpDetailsViewState extends State<SingleEmpDetailsView> {

  String name = '';
  String pos = '';
  String empId = '';
  String phone = '';
  String email = '';

  getEmployee() async {
    DocumentSnapshot employee =await FirebaseFirestore.instance.collection('employees').doc(widget.id).get();
    // print(employee.runtimeType);

    name = employee['empName'];
    pos= employee['empPos'];
    empId= employee['empId'];
    phone= employee['empPhone'];
    email= employee['empEmail'];
    setState(() {

    });
  }

  @override
  void initState() {
    getEmployee();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 160,),
              Text("$name Details",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Card(
                  child: Container(
                      width: MediaQuery.of(context).size.width-100,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(name,style: TextStyle(fontSize: 17,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      ))),
              SizedBox(height: 15,),

              Card(
                  child: Container(
                      width: MediaQuery.of(context).size.width-100,

                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(pos,style: TextStyle(fontSize: 17,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      ))),
              SizedBox(height: 15,),

              Card(
                  child: Container(
                      width: MediaQuery.of(context).size.width-100,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(empId,style: TextStyle(fontSize: 17,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      ))),
              SizedBox(height: 15,),

              Card(

                  child: Container(
                      width: MediaQuery.of(context).size.width-100,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(phone,style: TextStyle(fontSize: 17,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      ))),
              SizedBox(height: 15,),

              Card(
                  child: Container(
                      width: MediaQuery.of(context).size.width-100,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(email,style: TextStyle(fontSize: 17,color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                      ))),
              SizedBox(height: 15,),

              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child:Text("Back"))
            ],
          ),
        ),
      ),
    );
  }
}
