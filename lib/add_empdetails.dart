import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEmpDetails extends StatefulWidget {
  const AddEmpDetails({Key? key}) : super(key: key);

  @override
  State<AddEmpDetails> createState() => _AddEmpDetailsState();
}


class _AddEmpDetailsState extends State<AddEmpDetails> {
  final TextEditingController _textEditingController1=TextEditingController();
  final TextEditingController _textEditingController2=TextEditingController();
  final TextEditingController _textEditingController3=TextEditingController();
  final TextEditingController _textEditingController4=TextEditingController();
  final TextEditingController _textEditingController5=TextEditingController();
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new employee details"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text("Create a New Employee Details",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _textEditingController1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                 errorText: _validate ?'Invalid employee name' : null,

                      labelText:  "Enter employee name",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(20)
                        ),


                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null ;

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _textEditingController2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorText: _validate ?'Invalid emp pos' : null,
                      labelText: "Enter position",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter position';
                      }
                      return null ;

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _textEditingController3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorText: _validate ?'Invalid emp Id' : null,
                        labelText: "Enter id",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter id';
                      }
                      return null ;

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _textEditingController4,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      errorText: _validate ?'Invalid emp phone' : null,
                        labelText: "Enter phone number",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone number';
                      }
                      return null ;

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: _textEditingController5,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Enter  email",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                          borderRadius: BorderRadius.circular(20)
                      ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null ;

                    },

                  ),
                ),

                SizedBox(height: 15,),
               ElevatedButton(onPressed: (){
                 if(!_textEditingController1.text.isEmpty
                     &&!_textEditingController2.text.isEmpty
                     &&!_textEditingController3.text.isEmpty
                     &&!_textEditingController4.text.isEmpty
                     &&!_textEditingController5.text.isEmpty){
                   FirebaseFirestore.instance.collection('employees').add(
                       {
                         "empName":_textEditingController1.text.toUpperCase(),
                         "empPos":_textEditingController2.text,
                         "empId":_textEditingController3.text,
                         "empPhone":_textEditingController4.text,
                         "empEmail":_textEditingController5.text,
                       }
                   );
                   setState(() {

                     clearForm();
                   });

                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text('New employee details added successfully'),

                     ),
                   );
                    Navigator.of(context).pop();
                 }
                 else{
                    setState(() {

                    });
                    showDialog(context: context,
                        builder:(context) => AlertDialog(
                          content: Text("Invalid Form"),
                          actions: [
                            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
                          ],
                        ), );
                 }
               }, child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void clearForm(){
    _textEditingController1.clear();
    _textEditingController2.clear();
    _textEditingController3.clear();
    _textEditingController4.clear();
    _textEditingController5.clear();
  }


}
