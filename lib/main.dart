import 'package:bheem_kirana_store/provider/app_provider.dart';
import 'package:bheem_kirana_store/users/email_authentication/login_screen.dart';
import 'package:bheem_kirana_store/users/email_authentication/option_screen.dart';
import 'package:bheem_kirana_store/users/email_authentication/register_screen.dart';
import 'package:bheem_kirana_store/users/email_authentication/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VillageMall',
        theme: ThemeData(

            primarySwatch: Colors.red
        ),
          home: SplashSCreen(),
      )
    );
  }
}



