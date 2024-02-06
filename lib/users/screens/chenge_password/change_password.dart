import 'package:bheem_kirana_store/users/home_screen.dart';
import 'package:bheem_kirana_store/users/toast/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/round_button.dart';
class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController newcontroller=TextEditingController();
  TextEditingController confirmcontroller=TextEditingController();
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[100],
          title: Text("Change Password",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),
        ),
      body: SingleChildScrollView(
        child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: newcontroller,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      hintText: "New password",

                      border: OutlineInputBorder(
                        borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red ),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor:Colors.red,
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: confirmcontroller,
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(
                      hintText: "Confirm password",

                      border: OutlineInputBorder(
                        borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor:Colors.red[100],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RoundButton(title: "Update Password", onPress: () async{
                    if(newcontroller.text.isEmpty){
                      toastMessage().toastMassage("New Password is  empty");
                    }else if(confirmcontroller.text.isEmpty){
                      toastMessage().toastMassage("Confirm Password is  empty");
                    }else if(confirmcontroller.text==newcontroller.text){
                      _auth.currentUser!.updatePassword(newcontroller.text.toString());
                      toastMessage().toastMassage("Password update");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          HomeScreen()));
                    }
                    else{
                      toastMessage().toastMassage("Confirm Password is not match");
                    }
                  }),
                )
              ],


        ),
      ),
    );
  }
}
