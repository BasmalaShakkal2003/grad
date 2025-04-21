import 'package:flutter/material.dart';
import'home_screen.dart';

// -------------------------Student login screen---------------------------
class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/design1.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  Image.asset('assets/LOGO.png', width: 220, height: 180),
                  const SizedBox(height: 5),
                  _textField("Email"),
                  const SizedBox(height: 20),
                  _textField("Password", isPassword: true),
                  const SizedBox(height: 40),
                  _continueButton(context),
                  const SizedBox(height: 25),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/design2.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create text fields
  Widget _textField(String label, {bool isPassword = false}) {
    return SizedBox(
      height: 35,
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
          suffixIcon: isPassword ? const Icon(Icons.visibility_off) : null,
        ),
      ),
    );
  }

  // Create continue button
  Widget _continueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.zero,
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '"GradeEase" Would Like to Send You Notifications',
                        style: TextStyle(
                          fontFamily: 'Spartan',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF011226),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ],
                ),
                actions: [
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Don\'t Allow',
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 18,
                                color: Color(0xFF011226),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Allow',
                              style: TextStyle(
                                fontFamily: 'Space Mono',
                                fontSize: 18,
                                color: Color(0xFF011226),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF011226),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: const Text(
          "Continue",
          style:
              TextStyle(fontSize: 19, color: Colors.white, fontFamily: "Inter"),
        ),
      ),
    );
  }
}