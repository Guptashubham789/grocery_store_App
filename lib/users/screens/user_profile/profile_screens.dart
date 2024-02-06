import 'package:bheem_kirana_store/users/email_authentication/option_screen.dart';
import 'package:bheem_kirana_store/users/toast/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../provider/app_provider.dart';
import '../chenge_password/change_password.dart';
import 'edit_profile_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    AppProvider appProvider=Provider.of<AppProvider>(context,listen: false);
    appProvider.getUserInfoFirebase();
  }
  //FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //AppProvider appProvider=Provider.of<AppProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Text("Account",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),

      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children:  [
                  SizedBox(height: 10,),
                  appProvider.getUserInformation.image==null?
                  Icon(Icons.person_2_outlined,size: 115,)
                      :Image.network(appProvider.getUserInformation.image!,height: 200,width: 200,fit: BoxFit.cover,),
                  Text(appProvider.getUserInformation.name,
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'serif'),),
                  Text(appProvider.getUserInformation.email,style: TextStyle(fontFamily: 'serif'),),

                  SizedBox(height: 15,),
                  SizedBox(
                    height: 50,
                    child: CupertinoButton(
                      color: Colors.red[100],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ),
                        );
                      },

                      child: Text("Edit Account",style: TextStyle(fontFamily: 'serif',color: Colors.black87)),

                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children:
                [
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          ChangePassScreen(),));
                    },
                    leading: Icon(Icons.password),
                    title: Text("Change Password"),
                  ),
                  ListTile(
                    onTap: (){
                      _auth.signOut().then((value) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        //Navigator.push(context, CupertinoPageRoute(builder: (context)=> Welcome()));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(
                                builder: (context)=>OptionScreen())
                        );
                        toastMessage().toastMassage("Logout");
                      }).onError((error, stackTrace) {
                        toastMessage().toastMassage(error.toString());
                      });
                    },
                    leading: Icon(Icons.login_outlined),
                    title: Text("Logout"),
                  ),
                  SizedBox(height: 12,),
                  Text("Version 1.0.0")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
