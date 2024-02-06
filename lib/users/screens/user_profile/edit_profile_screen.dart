

import 'dart:io';
import 'package:bheem_kirana_store/provider/app_provider.dart';
import 'package:bheem_kirana_store/users/components/round_button.dart';
import 'package:bheem_kirana_store/users/firebase_helper/firebase_storage/firebase_storage.dart';
import 'package:bheem_kirana_store/users/models/user_models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../toast/toastmsg.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void takePicture() async{
   XFile?  value=await ImagePicker().pickImage(source: ImageSource.gallery);
   if(value!=null){
     setState(() {
       image=File(value.path);
     });
   }
  }
  TextEditingController textcontroller=TextEditingController();
  TextEditingController mobilecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(context,);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.red[100],
        title: Text("Edit Profile",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),

      ),
      body: ListView(
        children: [
            CupertinoButton(
              onPressed: (){
                  takePicture();
              },
              child: CircleAvatar(
                backgroundColor: Colors.red[100],
                radius: 70,
                child:image==null? Icon(Icons.camera_alt):Image.file(image!,width: 400,height: 700,fit: BoxFit.cover,),
              ),
            ),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: textcontroller,
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: appProvider.getUserInformation.name,

                border: OutlineInputBorder(
                  borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.person),
                prefixIconColor:Colors.pinkAccent,
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: mobilecontroller,
              keyboardType: TextInputType.number,
              decoration:  InputDecoration(
                hintText: "+91-"+appProvider.getUserInformation.mobile,

                border: OutlineInputBorder(
                  borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.phone_android),
                prefixIconColor:Colors.pinkAccent,
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: addresscontroller,
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: appProvider.getUserInformation.address,

                border: OutlineInputBorder(
                  borderRadius:BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.maps_home_work_rounded),
                prefixIconColor:Colors.pinkAccent,
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: RoundButton(title: "Update Profile", onPress: () async{
              UserModel userModel=appProvider.getUserInformation.copyWith(name: textcontroller.text,mobile:mobilecontroller.text,address:addresscontroller.text);
              appProvider.updateUserInfoFirebase(context, userModel,image!);
              toastMessage().toastMassage("Successfull update your account!!!");
              // String imageUrl=await FirebaseStorageHelper.instance.uploadUserImage(image!);
              // print(imageUrl);
            }),
          )
        ],
      ),
    );
  }
}
