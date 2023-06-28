import 'package:api/prefs/shared_pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      bool loggedIn = SharedPreController().getValueFor<bool>(key: Prefkeys.loggedIn.name) ?? false;
      String route = loggedIn? '/users_screen': '/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('App', style: GoogleFonts.poppins(
          fontSize: 30,
          fontWeight: FontWeight.bold,

        ),),
      ),
    );
  }
}
