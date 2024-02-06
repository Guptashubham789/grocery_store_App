import 'package:flutter/material.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.red[100],
        title: Text("My Wishlist",style: TextStyle(color: Colors.black87,fontFamily: 'serif'),),

      ),
    );
  }
}
