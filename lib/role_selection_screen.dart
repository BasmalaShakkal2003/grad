import 'package:flutter/material.dart';
import 'student_login_screen.dart';
import 'doctor_login_screen.dart';

// --------------------Role selection screen---------------------------
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset('assets/LOGO.png', width: 230, height: 350),
          const Spacer(),
          Container(
            height: 460,
            decoration: const BoxDecoration(
              color: Color(0xFF011226),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _roleCard(
                      context: context,
                      imagePath: 'assets/STUDENT.png',
                      label: "Student",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudentLoginScreen()),
                        );
                      },
                    ),
                    _roleCard(
                      context: context,
                      imagePath: 'assets/SUPERVISOR.png',
                      label: "Supervisor",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorLoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Create role cards
  Widget _roleCard({
    required BuildContext context,
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF041C40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 100,
                height: 100,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              fontFamily: "Spectral",
            ),
          ),
        ],
      ),
    );
  }
}
