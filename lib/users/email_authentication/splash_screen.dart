import 'dart:async';

import 'package:bheem_kirana_store/users/email_authentication/option_screen.dart';
import 'package:bheem_kirana_store/users/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {
  FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user=_auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 2),
              ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()))
      );
    }else{
      Timer(Duration(seconds: 2),
              ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=> OptionScreen()))
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
                height: MediaQuery.of(context).size.height*.6,
                width: MediaQuery.of(context).size.width*.6,
                image: AssetImage('images/logo/applogo.jpg')),
            SizedBox(height: 50,),
            Text("Version 1.0.1",style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),),
            SizedBox(height: 10,),
            Text("Developed by- SSG",style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic,fontFamily: 'serif'),)
          ],
        ),
      ),
    );
  }
}
