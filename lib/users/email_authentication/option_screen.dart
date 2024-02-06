import 'package:bheem_kirana_store/users/email_authentication/login_screen.dart';
import 'package:bheem_kirana_store/users/email_authentication/register_screen.dart';
import 'package:flutter/material.dart';


import '../components/round_button.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("images/logo/splashpic.jpg")),
              SizedBox(height: 30,),
              RoundButton(
                  title: "Login",
                  onPress: (){
                    Navigator.push(
                        context,MaterialPageRoute(builder: (Context)=> LoginScreen()));
                  }),
              SizedBox(height: 30,),
              RoundButton(title: "Register", onPress: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (Context)=> RegisterScreen()));
              }),
              SizedBox(height: 50,),
              Text("Developed by- SSG",style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic,fontFamily: 'serif'),)

            ],
          ),
        ),
      ),
    );
  }
}
