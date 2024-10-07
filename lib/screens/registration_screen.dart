import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farfoshmodi/screens/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen height and width to make the layout responsive
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/colorcircle.png'), // Background image
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Foreground content (text and buttons)
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                // Space between image and text
                SizedBox(height: screenHeight * 0.5),
                // "مرحبا!" Text
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                  child: Text(
                    'مرحباً!',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 38, // Adjust size for large text
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D2240), // Adjust color as needed
                    ),
                  ),
                ),
                // "تسجيل الدخول" Elevated Button
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1, vertical: 15),
                      backgroundColor: Color(0xFF0D2240), // Navy Blue color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // "انضم لنا" Outlined Button
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1, vertical: 15),
                      side: BorderSide(
                        color: Color(0xFF0D2240), // Navy Blue border
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'انضم لنا',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Color(0xFF0D2240), // Navy Blue text color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
