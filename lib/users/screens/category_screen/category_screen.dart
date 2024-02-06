import 'package:bheem_kirana_store/users/home_screen.dart';
import 'package:bheem_kirana_store/users/screens/category_screen/category_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebase_helper/firebase_firestore.dart';
import '../../models/category_models.dart';



class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categoriesList=[];
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    getCategoriesList();
    super.initState();
  }
  void getCategoriesList() async {
    setState(() {
      isLoading=true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategory();
    categoriesList.shuffle();
    setState(() {
      isLoading=false;
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title: Text("Category",style: TextStyle(color: Colors.black87,fontFamily: 'serif')),
      ),
      body: categoriesList.isEmpty?Center(child: Text("Categories is empaty"),):SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: categoriesList.length,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (ctx,index){
                      CategoryModel singleProduct=categoriesList[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(

                          decoration: BoxDecoration(
                              color: Colors.white70 ,
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: CupertinoButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  CategoryView(categoryModel: singleProduct,),));
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Image.network(singleProduct.image,height: 110,width: 150,),
                                SizedBox(height: 10,),
                                Center(
                                  child: Text(singleProduct.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,fontStyle: FontStyle.italic,color: Colors.black87,fontFamily: 'serif'),),
                                ),


                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 50,)
              ],
            ),
          ],
        ),

      ),
          

    );
  }
}
//
// Row(
// children: categoriesList.map((e) => Padding(
// padding: const EdgeInsets.all(12.0),
// child: CupertinoButton(
// padding: EdgeInsets.zero,
// onPressed: (){
// Navigator.push(context, MaterialPageRoute(builder: (context)=>
// CategoryView(categoryModel: e,),));
// },
// child: Card(
// color: Colors.white,
//elevation: 3.0,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20.0),
// ),
// child: Column(
// children: [
// SizedBox(
// height: 100,
// width: 100,
// child: Image.network(e.image),
// ),
// Center(
// child: Text(e.name,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,fontStyle: FontStyle.italic,color: Colors.red),),
// )
// ],
// ),
//
//
// ),
// ),
// )).toList(),
// ),
//
