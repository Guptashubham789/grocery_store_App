import 'package:bheem_kirana_store/users/email_authentication/option_screen.dart';
import 'package:bheem_kirana_store/users/screens/category_screen/category_screen.dart';
import 'package:bheem_kirana_store/users/screens/category_screen/category_view_screen.dart';
import 'package:bheem_kirana_store/users/screens/chenge_password/change_password.dart';
import 'package:bheem_kirana_store/users/screens/product_details/product_details.dart';
import 'package:bheem_kirana_store/users/screens/user_profile/profile_screens.dart';
import 'package:bheem_kirana_store/users/screens/whichlist_screen/favorite_screen.dart';
import 'package:bheem_kirana_store/users/toast/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import 'firebase_helper/firebase_firestore.dart';
import 'models/category_models.dart';
import 'models/products_models.dart';
import 'models/sliders_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList=[];
  List<SlidersModel> slidersList=[];
  List<ProductModel> productsList=[];
  final List _source=[Colors.red,Colors.green,Colors.blue];
  final mycurrentIndex=0;
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    getCategoriesList();
    getSlidersList();
    super.initState();
  }
  void getCategoriesList() async {
    setState(() {
      isLoading=true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategory();
    productsList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productsList.shuffle();
    //categoriesList.shuffle();
    setState(() {
      isLoading=false;
    });

  }
  void getSlidersList() async {
    setState(() {
      isLoading=true;
    });
    slidersList = await FirebaseFirestoreHelper.instance.getSliders() as List<SlidersModel>;

    //categoriesList.shuffle();
    setState(() {
      isLoading=false;
    });

  }
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
   // final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        title:Text("Kirana Store",style: TextStyle(fontFamily: 'serif',color: Colors.black87),),
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> OptionScreen()));
              toastMessage().toastMassage("Logout");
              setState(() {

              });
            }).onError((error, stackTrace) {
              toastMessage().toastMassage(error.toString());
            });
          }, icon:Icon(Icons.exit_to_app,color: Colors.black87,)),
        ],

      ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.red[100],
          shadowColor: Colors.red[100],
          elevation: 10,
          width: 250,
          clipBehavior: Clip.hardEdge,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 50,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bheem Kirana Store",style: TextStyle(fontFamily: 'serif',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.red[300],fontSize: 18),),
                  ),

                  //Text(appProvider.getUserInformation.name),
                  //Text(appProvider.getUserInformation.mobile)

                ],
              ),
              Divider(),

              ListTile(
                leading: Icon(Icons.home,color: Colors.red[200],),
                title: Text('Home',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      HomeScreen(),));
                  // Add navigation logic here.
                },
              ),
              ListTile(
                leading: Icon(Icons.dashboard,color: Colors.red[200],),
                title: Text('Categories',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      CategoryScreen(),));
                  // Add navigation logic here.
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart,color: Colors.red[200],),
                title: Text('Add To Cart',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  // Add navigation logic here.
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag,color: Colors.red[200],),
                title: Text('Order',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  // Add navigation logic here.
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite_rounded,color: Colors.red[200],),
                title: Text('My Wishlist',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      FavoriteScreen(),));
                  // Add navigation logic here.
                },
              ),
              ListTile(
                leading: Icon(Icons.person,color: Colors.red[200],),
                title: Text('Account',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      ProfileScreen(),));
                  // Add navigation logic here.
                },
              ),

              ListTile(
                leading: Icon(Icons.settings,color: Colors.red[200],),
                title: Text('Settings',style: TextStyle(fontFamily: 'lancelot',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                onTap: () {
                  // Add navigation logic here.
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.red,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.red,)),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.call,color: Colors.red,)),
                    IconButton(onPressed: (){
                      toastMessage().toastMassage("Thank You For Like This Application");
                    }, icon: Icon(Icons.favorite_outlined,color: Colors.red,))
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Center(child: Text("Version 1.0.0"))

            ],
          ),
        ),
      body:isLoading?Center(child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search..",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 140.0,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,

              ),
              items: slidersList.map((i){
                return Builder(
                    builder: (BuildContext context){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 110,
                                      width: MediaQuery.of(context).size.width,
                                      child:Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Image.network(i.image,fit: BoxFit.cover,height: 100,),
                                          ],
                                        ),
                                      )
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    });
              }).toList(),
            ),
            const Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Categories",
                style: TextStyle(fontSize: 18.0,
                    fontWeight: FontWeight.bold),),
            ),
            categoriesList.isEmpty?Center(child: Text("Categories is empaty"),):SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoriesList.map((e) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>
                           CategoryView(categoryModel: e,),));
                    },
                    child: Card(
                      color: Colors.red[50],
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 100,
                            child:Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Image.network(e.image,height: 80,),
                                  SizedBox(height: 5,),
                                  Text(e.name,style: TextStyle(fontSize: 9,fontFamily: 'serif',fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          ),

                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Top items",
                style: TextStyle(fontSize: 18.0,
                    fontWeight: FontWeight.bold),),
            ),
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


            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
