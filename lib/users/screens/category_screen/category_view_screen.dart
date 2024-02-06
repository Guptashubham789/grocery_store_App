import 'package:bheem_kirana_store/users/screens/product_details/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../firebase_helper/firebase_firestore.dart';
import '../../models/category_models.dart';
import '../../models/products_models.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key,required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productsList=[];
  bool isLoading=false;
  void initState(){
    getCategoriesList();
    super.initState();
  }
  void getCategoriesList() async {
    setState(() {
      isLoading=true;
    });

    productsList = await FirebaseFirestoreHelper.instance.getCategoryProduct(widget.categoryModel.id);
    productsList.shuffle();
    //this function random the item
    //categoriesList.shuffle();
    setState(() {
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
          title: Text(widget.categoryModel.name,style: TextStyle(fontFamily: 'serif',color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                itemCount: productsList.length,
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (ctx,index){
                  ProductModel singleProduct=productsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.grey[100] ,
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: CupertinoButton(
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          //HomeScreen(categoryModel: singleProduct,),));
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Image.network(singleProduct.image,height: 60,width: 80,),
                            SizedBox(
                              height: 3,
                            ),
                            Text(singleProduct.name,style: TextStyle(color: Colors.black,fontFamily: 'serif',fontSize: 14),),
                            Text("Price: ${singleProduct.price}",style: TextStyle(color: Colors.red.shade200,fontFamily: 'serif',fontSize: 14),),
                            SizedBox(height: 5,),
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    // primary: Colors.red,
                                      side:  BorderSide(
                                          color: Colors.red.shade100,
                                          width: 1.1
                                      )
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                        ProductScreen(singleProduct: singleProduct,),));
                                  },
                                  child:  Text(
                                    "Buy",style: TextStyle(color:Colors.red.shade300,fontSize: 14,fontFamily: 'serif'),)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
