import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/signinwith.dart';
import 'package:crud_operation/single_empdetails_viw.dart';
import 'package:crud_operation/update_empdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Add new employee'),
                  duration: Duration(seconds: 1),

                ));
            Navigator.pushNamed(context, "add_empdetails");
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () async {
                     await googleSignIn.signOut();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                        return SignInWith();
                      },));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInWith(),));
                    }, child: Container(
                        width: 100,
                        height: 50,
                        child: Card(
                          // color: Colors.red,
                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Row(
                              children: [
                                SizedBox(width: 10,),
                                Text("Logout",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),),
                                Icon(Icons.logout,color: Colors.red,)
                              ],
                            )))))
                  ],
                ),
                SizedBox(height: 20,),
                Center(child: Text("All Employee Details",style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),)),
                SizedBox(height: 20,),
                Container(
                  height: MediaQuery.of(context).size.height-100,
                  width:  MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('employees').snapshots(),

                    builder: (context, snapshot) {
if(!snapshot.hasData){
  return Center(
      child: CircularProgressIndicator(),
  );
}
                      var data = snapshot.data?.docs;

                      return ListView.separated(
                          itemCount: data?.length??1,
                        itemBuilder: (context, index) {
                        return Dismissible(

                          background: Row(
                            children: [
                              // Text('Delete',style: TextStyle(
                              //   color: Colors.red
                              // ),),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                color: Colors.red,

                              )
                            ],
                          ),
                          onDismissed: (direction){
                            FirebaseFirestore.instance.collection('employees').doc(data?[index].id).delete();
                          },
                          key: GlobalKey(),
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return SingleEmpDetailsView(
                                  id: data?[index].id ,
                                );
                              },));
                            },
                            title: Text(" ${data?[index]['empName']}",style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8,),
                                Text(" ${data?[index]['empPos']}",style: TextStyle(color: Colors. blueGrey,fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(data?[index]['empId'],style: TextStyle(color: Colors. blueGrey,fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(data?[index]['empPhone'],style: TextStyle(color: Colors. blueGrey,fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(height: 5,),
                                Text(data?[index]['empEmail'],style: TextStyle(color: Colors. blueGrey,fontSize: 15,fontWeight: FontWeight.bold),),
                              ],
                            ),trailing: Container(
                            width: 50,
                              height: 60,

                              child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return updateEmpDetails(
                                    empName: "${data?[index]['empName']}",
                                    empPos: "${data?[index]['empPos']}",
                                    empID:"${data?[index]['empId']}" ,
                                    empPhone: "${data?[index]['empPhone']}",
                                    empEmail: "${data?[index]['empEmail']}",
                                    id: data?[index].id??'',
                                  );
                                },));
                              },
                              child: Row(
                                children: [
                                  Text("edit",style: TextStyle(fontSize: 15,color: Colors.deepPurple),),
                                  Icon(Icons.edit,size: 16,color: Colors.deepPurple,)
                                ],
                              ),
                          ),
                            ),
                          ),
                        );
                      }, separatorBuilder: (context, index) {
                        return Divider(color: Colors.blue,);
                      }, );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
