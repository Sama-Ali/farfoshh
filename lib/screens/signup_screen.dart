import 'dart:typed_data';
import 'package:farfoshmodi/resources/auth_method.dart';
import 'package:farfoshmodi/responsive/mobile_screen_layout.dart';
import 'package:farfoshmodi/responsive/responsive_layout_screen.dart';
import 'package:farfoshmodi/responsive/web_screen_layout.dart';
import 'package:farfoshmodi/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:farfoshmodi/widgets/text_field_input.dart';
import 'package:farfoshmodi/Utils/utils.dart';
import 'package:image_picker/image_picker.dart'; //for pick image
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: CreateAccountPage(),
  ));
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // Controllers for the text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      username: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      //     file: _image!
    );
    // ya
    //String res = await AuthMethod().signUpUser(
    //   username: "_nameController.text",
    //   email: "hh@gmail.com",
    //   password: "passwordController.text",
    //   //
    // );
    setState(() {
      _isLoading = false;
    });
    if (res != "!تم") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigatToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  // Profile Picture
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundColor: Color(0xFFE0E0E0),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Color(0xFF37474F),
                              ),
                            ),
                      // Make the camera icon clickable
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: selectImage,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Name Field
                  TextFieldInput(
                    textEditingController: _nameController,
                    labelText: 'اسم المستخدم',
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  // Email Field
                  TextFieldInput(
                    textEditingController: _emailController,
                    labelText: 'البريد الالكتروني',
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  // Birth Date Field
                  // TextFieldInput(
                  //   textEditingController: _birthDateController,
                  //   labelText: 'تاريخ الميلاد',
                  //   textInputType: TextInputType.datetime,
                  // ),
                  // SizedBox(height: 20),
                  // Password Field
                  TextFieldInput(
                    textEditingController: _passwordController,
                    labelText: 'كلمة المرور',
                    textInputType: TextInputType.visiblePassword,
                    isPass: true,
                  ),
                  SizedBox(height: 40),
                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: signUpUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // "لدي حساب بالفعل" TextButton
                  Center(
                    child: TextButton(
                      onPressed: navigatToLogin,
                      child: Text(
                        'لدي حساب بالفعل',
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          color: Color(0xFF0D2240)
                              .withOpacity(0.7), // Dark blue with opacity
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
