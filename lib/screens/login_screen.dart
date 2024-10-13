import 'package:farfoshmodi/Utils/utils.dart';
import 'package:farfoshmodi/resources/auth_method.dart';
import 'package:farfoshmodi/responsive/mobile_screen_layout.dart';
import 'package:farfoshmodi/responsive/responsive_layout_screen.dart';
import 'package:farfoshmodi/responsive/web_screen_layout.dart';
import 'package:farfoshmodi/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farfoshmodi/widgets/text_field_input.dart'; // Import reusable component

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    // Call backend login method
    String res = await AuthMethod().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (res == "!تم") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false; // Set loading state to false
    });
  }

  void navigatToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateAccountPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height and width for responsive layout
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: screenHeight * 0.05), // Space from the top

            // "مرحباً!" Text
            Text(
              'مرحباً!',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl, // Aligns text to the right
              style: GoogleFonts.cairo(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D2240), // Dark color
              ),
            ),

            // "سجل الدخول للاستمرار" Subtitle
            Text(
              'سجل الدخول للاستمرار',
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 12,
                color: Color(0xFF0D2240)
                    .withOpacity(0.7), // Dark color with opacity
              ),
            ),

            SizedBox(height: screenHeight * 0.05), // Space after text

            // Email TextFieldInput
            TextFieldInput(
              textEditingController: _emailController,
              labelText: 'البريد الإلكتروني',
              textInputType: TextInputType.emailAddress,
            ),

            SizedBox(height: screenHeight * 0.02), // Space between fields

            // Password TextFieldInput
            TextFieldInput(
              textEditingController: _passwordController,
              labelText: 'كلمة المرور',
              textInputType: TextInputType.text,
              isPass: true,
            ),

            SizedBox(
                height: screenHeight * 0.08), // Space between fields and button

            // "تسجيل الدخول" Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: 15), // Responsive padding
                  backgroundColor: Color(0xFF0D2240), // Dark blue color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                onPressed: _isLoading
                    ? null // Disable button while loading
                    : loginUser,
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'تسجيل الدخول',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            SizedBox(
                height: screenHeight *
                    0.01), // Space between button and forgot password

            // "ليس لديك حساب؟ أنشئ حسابك" TextButton
            Center(
              child: TextButton(
                onPressed: navigatToSignup,
                child: Text(
                  'ليس لديك حساب؟ أنشئ حسابك',
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
    );
  }
}
