import 'package:api/prefs/shared_pref_controller.dart';
import 'package:api/screens/Image_picker_screen.dart';
import 'package:api/screens/images_screen.dart';
import 'package:api/screens/launch_screen.dart';
import 'package:api/screens/login_screen.dart';
import 'package:api/screens/regiser_screen.dart';
import 'package:api/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await SharedPreController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
           titleTextStyle: GoogleFonts.poppins(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
             color: Colors.black
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context)=>const LaunchScreen(),
        '/users_screen': (context)=>const UserScreen(),
        '/login_screen':(context)=>const LoginScreen(),
        '/register_screen':(context)=>const RegisterScreen(),
        '/images_screen' : (context) => const ImagesScreen(),
        '/image_picker': (context) => const ImagePickerScreen(),

      },
    );
  }
}

