import 'package:bheem_kirana_store/users/home_screen.dart';
import 'package:bheem_kirana_store/users/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/round_button.dart';
import '../toast/toastmsg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController mobilecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();

  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  final _formKey=GlobalKey<FormState>();
  String email="",password="",name="",mobile="",address="";
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register",style: TextStyle(fontFamily: 'Serif',color: Colors.black87),),
          backgroundColor: Colors.red[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Text("Create new Account!",style: TextStyle(fontSize: 24,fontFamily: 'serif'),),
              SizedBox(height: 30,),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                            prefixIcon: Icon(Icons.person_sharp),
                            prefixIconColor:Colors.pinkAccent,
                          ),
                          onChanged: (String value){
                            name=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter name':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                            prefixIconColor:Colors.pinkAccent,
                          ),
                          onChanged: (String value){
                            email=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter email':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            labelText: "Password",

                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.lock_clock_outlined),
                            prefixIconColor:Colors.pinkAccent,
                          ),
                          onChanged: (String value){
                            password=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter password':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: mobilecontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Mobile",
                            labelText: "Mobile",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            prefixIconColor:Colors.pinkAccent,
                          ),
                          onChanged: (String value){
                            mobile=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter mobile number':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: addresscontroller,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: "Address",
                            labelText: "Address",
                            border: OutlineInputBorder(
                              borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.home),
                            prefixIconColor:Colors.pinkAccent,
                          ),
                          onChanged: (String value){
                            address=value;
                          },
                          validator:(value){
                            return value!.isEmpty?'Enter address':null;
                          },
                        ),
                        SizedBox(height: 20,),
                        RoundButton(title: "Create a new account", onPress: ()async{
                          if(_formKey.currentState!.validate()){
                            //User();
                            setState(() {
                              showSpinner=true;
                            });
                            try{
                              UserCredential userCreadential=await _auth.createUserWithEmailAndPassword(
                                  email: email.toString().trim(),
                                  password: password.toString().trim()
                              );
                              UserModel userModel=UserModel(
                                  id: userCreadential.user!.uid,
                                  name: name,
                                  email: email,
                                  address: address,
                                  mobile: mobile,
                                  password: password);
                              firestore.collection("users").doc(userModel.id).set(userModel.toJson());
                              if(userCreadential!=null){
                                toastMessage().toastMassage('Welcome To  ${emailcontroller.text.toString()}');
                                setState(() {
                                  showSpinner=false;
                                });
                                Navigator.popUntil(context, (route) => route.isFirst);
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (Context)=>HomeScreen()));
                              }
                            }catch(e){
                              // print(e.toString());
                              toastMessage().toastMassage(e.toString());
                              setState(() {
                                showSpinner=false;
                              });
                            }
                          }
                        })
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
