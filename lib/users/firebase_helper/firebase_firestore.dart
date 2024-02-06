import 'package:bheem_kirana_store/users/toast/toastmsg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_models.dart';
import '../models/products_models.dart';
import '../models/sliders_models.dart';
import '../models/user_models.dart';

class FirebaseFirestoreHelper{
  static FirebaseFirestoreHelper instance=FirebaseFirestoreHelper();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //user send data in firestore database
  Future<UserModel> getUserInformation() async{
    DocumentSnapshot<Map<String,dynamic>> querySnapshot=
    await _firebaseFirestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserModel.fromJson(querySnapshot.data()!);
  }
  //get user record on  the id basis
  Future<UserModel> getCategories(String id) async{
    DocumentSnapshot<Map<String,dynamic>> querySnapshot=
    await _firebaseFirestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserModel.fromJson(querySnapshot.data()!);
  }

  //get category firebase
  Future<List<CategoryModel>> getCategory() async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot=
      await _firebaseFirestore.collection("categories").get();
      List<CategoryModel> categoriesList=querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoriesList;
    }catch (e){
      toastMessage().toastMassage(e.toString());
      print(e);
      return [];
    }
  }

  //get product firebase
  Future<List<ProductModel>> getBestProducts() async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot=
      await _firebaseFirestore.collectionGroup("products").get();
      List<ProductModel> productsList=querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return productsList;
    }catch (e){
      toastMessage().toastMassage(e.toString());
      //log(e.toString());
      return [];
    }
  }

  //get category wise item show the category view firebase
  Future<List<ProductModel>> getCategoryProduct(String id) async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot=
      await _firebaseFirestore.collection("categories").doc(id).collection("products").get();
      List<ProductModel> productsList=querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return productsList;
    }catch (e){
      toastMessage().toastMassage(e.toString());
      //log(e.toString());
      return [];
    }
  }

  //get slider image
  Future<List<Object>> getSliders() async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot=
      await _firebaseFirestore.collection("sliders").get();
      List<SlidersModel> slidersList=querySnapshot.docs
          .map((e) => SlidersModel.fromJson(e.data()))
          .toList();
      return slidersList;
    }catch (e){
      toastMessage().toastMassage(e.toString());
      print(e);
      return [];
    }
  }
}