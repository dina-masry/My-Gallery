import 'package:api/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/api_response.dart';
import '../api/auth_api_controller.dart';
import '../widgets/app_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  String _gender ='M';

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            Text(
              'enter your details',
              style: GoogleFonts.poppins(
                height: 1.0,
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: Colors.black45,
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _nameTextController,
              prefixIcon: Icons.person,
              hint: 'name',
              textInputType: TextInputType.name,
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _emailTextController,
              prefixIcon: Icons.email,
              hint: 'email',
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _passwordTextController,
              prefixIcon: Icons.lock,
              hint: 'password',
              obscureText: true,
            ),const SizedBox(height: 10),
        Row(
            children: [
        Expanded(
        child: RadioListTile(
        title: const Text('Male'),
        value: 'M',
        groupValue: _gender,
        onChanged: (String? value) {
          if (value != null) {
            setState(() => _gender = value);
          }
        },
      ),
    ),
    Expanded(
    child: RadioListTile(
    title: const Text('Female'),
    value: 'F',
    groupValue: _gender,
    onChanged: (String? value) {
    if (value != null) {
    setState(() => _gender = value);
    }
    },
    ),    ),
            ],
        ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _preformRegister(),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                'register',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _preformRegister() {
    if (_checkData()) {
      _register();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _register() async {
    ApiResponse apiResponse = await AuthApiController().register(fullName: _nameTextController.text, email: _emailTextController.text, password: _passwordTextController.text, gender: _gender);
    context.showSnackBar(message: apiResponse.message , error: !apiResponse.success);
    if(apiResponse.success){
      Navigator.pushReplacementNamed(context, '/login_screen');
    }else{
      print('hi');
    }
  }
}