import 'dart:io';

import 'package:bheem_kirana_store/users/firebase_helper/firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../users/firebase_helper/firebase_firestore.dart';
import '../users/models/user_models.dart';

class AppProvider with ChangeNotifier{

  //Cart screen product add and remove with provider
 // final List<ProductModel> _cartProductList=[];
  UserModel? _userModel;
  File? file;
   UserModel get getUserInformation => _userModel!;
  //
  // void addCartProduct(ProductModel productModel){
  //   _cartProductList.add(productModel);
  //   notifyListeners();
  // }
  //
  // void removeCartProduct(ProductModel productModel){
  //   _cartProductList.remove(productModel);
  //   notifyListeners();
  // }
  //
  // List<ProductModel> get getCartProductList => _cartProductList;
  //
  // //Favrt screen product add and remove with provider
  // final List<ProductModel> _favrtProductList=[];
  // void addFavrtProductList(ProductModel productModel){
  //   _favrtProductList.add(productModel);
  //   notifyListeners();
  // }
  //
  // void removeFavrtProductList(ProductModel productModel){
  //   _favrtProductList.remove(productModel);
  //   notifyListeners();
  // }
  // List<ProductModel> get getFavrtProductList => _favrtProductList;

//user get tha information
  void getUserInfoFirebase() async{
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(BuildContext context,UserModel userModel,File file) async{

    if(file==null){
     await FirebaseFirestore.instance.collection("users").doc(userModel.id).set(userModel.toJson());
    }else{
       String imageUrl=
           await FirebaseStorageHelper.instance.uploadUserImage(file);
       _userModel =userModel.copyWith(image: imageUrl);
       await FirebaseFirestore.instance.collection("users").doc(_userModel!.id).set(_userModel!.toJson());
      notifyListeners();
    }
    Navigator.of(context).pop();

  }




}