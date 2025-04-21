import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../supervisor widgets/custom_navbar.dart';

class UIUXScreen extends StatefulWidget {
  const UIUXScreen({super.key});

  @override
  _UIUXScreenState createState() => _UIUXScreenState();
}

class _UIUXScreenState extends State<UIUXScreen> {
  int _selectedIndex = 1;
  late double screenWidth;
  late double screenHeight;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/groups');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
    }
  }

  void _showGradeDialog(BuildContext context) {
    TextEditingController gradeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
            child: Container(
              width: screenWidth * 0.5,
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: const Color.fromARGB(241, 252, 251, 251),
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.05,
                    child: TextField(
                      controller: gradeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: screenWidth * 0.045),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.01,
                          horizontal: screenWidth * 0.03),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF0F5C8C)),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.02),
                          child: Text(
                            "/ 10",
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.35,
                    height: screenHeight * 0.05,
                    child: ElevatedButton(
                      onPressed: () {
                        String enteredGrade = gradeController.text;
                        Navigator.pop(context);
                        print("Grade Entered: $enteredGrade / 10");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF093754),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03)),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background Layers
          Positioned(
            top: -screenHeight * 0.2,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Container(
              height: screenHeight * 0.42,
              decoration: BoxDecoration(
                color: const Color(0xFF041C40),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.4),
                  bottomRight: Radius.circular(screenWidth * 0.4),
                ),
              ),
            ),
          ),
          Positioned(
            top: -screenHeight * 0.15,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Container(
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                color: const Color(0xFF011226),
                borderRadius: BorderRadius.circular(screenWidth * 0.3),
              ),
            ),
          ),

          SafeArea(
            child: Stack(
              children: [
                // Back Arrow
                Positioned(
                  top: screenHeight * 0.06,
                  left: screenWidth * 0.04,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: screenWidth * 0.06,
                      color: Colors.white,
                    ),
                  ),
                ),

                // UI/UX Title
                Positioned(
                  top: screenHeight * 0.1,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "UI/UX",
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                  ),
                ),

                // Main Content
                Column(
                  children: [
                    SizedBox(height: screenHeight * 0.2),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04),
                        child: Column(
                          children: [
                            _buildTaskCard("Habiba Mohamed", "Wireframes"),
                            SizedBox(height: screenHeight * 0.02),
                            _buildTaskCard("Omar Ali", "Mockups"),
                            SizedBox(height: screenHeight * 0.02),
                            _buildTaskCard("Salma Ibrahim", "Prototyping"),
                            SizedBox(height: screenHeight * 0.1),
                          ],
                        ),
                      ),
                    ),

                    // Navbar
                    Container(
                      width: screenWidth * 0.65,
                      height: screenHeight * 0.08,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.1)),
                      child: CustomNavBar(
                        selectedIndex: _selectedIndex,
                        onItemTapped: _onItemTapped,
                      ),
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

  Widget _buildTaskCard(String studentName, String taskTitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.03),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$studentName submitted $taskTitle",
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          ),
          SizedBox(height: screenHeight * 0.01),

          Row(
            children: [
              Image.asset(
                'assets/icons/pdf.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.01),

              Text(
                "PDF",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(width: screenWidth * 0.02),

              SvgPicture.asset(
                'assets/icons/pdf2.svg',
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
                colorFilter: const ColorFilter.mode(
                  Colors.grey, BlendMode.srcIn),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          SizedBox(
            width: screenWidth * 0.3,
            height: screenHeight * 0.04,
            child: ElevatedButton(
              onPressed: () => _showGradeDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093754),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                "Add Grade",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}