import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farfoshmodi/screens/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting the height and width of the screen for responsiveness
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
                image: AssetImage('assets/welcome.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content (text and button)
          Positioned.fill(
            child: Column(
              children: [
                // Space between image and text
                SizedBox(height: screenHeight * 0.6),
                // Text Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'أهلاً بك في عالم فرفوش',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color:
                            const Color(0xffffffff), // Black for more contrast
                      ),
                    ),
                  ),
                ),
                // Space between text and button
                SizedBox(height: screenHeight * 0.01),
                // Button Section
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.09, vertical: 10),
                    backgroundColor:
                        const Color.fromRGBO(32, 175, 161, 1), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation:
                        3, // Set to 0 because we are using a custom shadow
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: Text(
                    'هيا لنبدأ !',
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Spacer to fill the remaining space
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
