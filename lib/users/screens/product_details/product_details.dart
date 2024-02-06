import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/products_models.dart';
import '../user_profile/edit_profile_screen.dart';
class ProductScreen extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductScreen({super.key,required this.singleProduct});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int qty=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  IconButton(onPressed: (){

                  }, icon:Icon(Icons.favorite_outline_sharp,color: Colors.red[100],))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 350,
                  width: double.infinity,

                  child: Container(
                    //color: Colors.red[100],
                    child: Card(
                      color: Colors.red[50],
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(


                              child:Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Image.network(widget.singleProduct.image,height: 300,),
                                    //Text(e.name,style: TextStyle(fontSize: 10,fontFamily: 'serif'),)
                                  ],
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    Text(widget.singleProduct.name,style: TextStyle(fontFamily: "serif",color: Colors.black87,fontSize: 20 ),),
                    SizedBox(height: 10,),
                    Text("Price: ${widget.singleProduct.price}",style: TextStyle(fontFamily: "serif",color: Colors.red,fontSize: 15 )),
                    //Text("Price: ${widget.singleProduct.description}",style: TextStyle(fontFamily: "serif",color: Colors.red,fontSize: 15 )),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            if(qty>=1){
                              setState(() {
                                qty--;
                              });
                            }
                          },
                          padding: EdgeInsets.zero,
                          child: CircleAvatar(
                            backgroundColor: Colors.red[100],
                            child: Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Text(qty.toString(),style: TextStyle(fontSize: 18),),
                        SizedBox(width: 12,),
                        CupertinoButton(
                          onPressed: () {
                            setState(() {
                              qty++;
                            });
                          },
                          padding: EdgeInsets.zero,
                          child: CircleAvatar(
                            backgroundColor: Colors.red[100],
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 280,
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

                  child: Text("Buy",style: TextStyle(fontFamily: 'serif',color: Colors.black87)),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
