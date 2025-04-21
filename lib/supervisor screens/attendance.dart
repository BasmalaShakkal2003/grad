import 'package:flutter/material.dart';
import 'package:flutter_application_1/supervisor%20screens/note.dart';
import 'done.dart';  

class AttendanceScreen extends StatelessWidget {
  final NoteModel note;
  final String groupName;

  const AttendanceScreen({
    Key? key,
    required this.note,
    required this.groupName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Base Layer
          Positioned(
            top: -screenHeight * 0.17,
            left: -screenWidth * 0.08,
            right: -screenWidth * 0.08,
            child: Container(
              width: screenWidth * 1.3,
              height: screenHeight * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xFF041C40),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.4),
                  bottomRight: Radius.circular(screenWidth * 0.4),
                ),
              ),
            ),
          ),

          // Overlay Layer
          Positioned(
            top: -screenHeight * 0.16,
            left: -screenWidth * 0.1,
            right: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 1.3,
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                color: const Color(0xFF011226),
                borderRadius: BorderRadius.circular(screenWidth * 0.3),
              ),
            ),
          ),

          // Back Arrow
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.03,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: screenWidth * 0.07,
                color: Colors.white,
              ),
            ),
          ),

          // Title
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Attendance",
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Insert Student's ID Text
          Positioned(
            top: screenHeight * 0.3,
            left: screenWidth * 0.05,
            child: Text(
              'Insert Student’s ID',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF041C40),
              ),
            ),
          ),

          // Student ID TextField
          Positioned(
            top: screenHeight * 0.34,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Container(
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: const Color(0xFFDBDBDB),
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
              ),
            ),
          ),

          // Add Button  
          Positioned(
            bottom: screenHeight * 0.12,
            left: screenWidth * 0.25,
            right: screenWidth * 0.25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoneScreen(
                      groupName: groupName,
                      taskData: {
                        'meetingTitle': note.title,
                        'date': note.date,
                        'meetingType': note.meetingType,
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF041C40),
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.07),
                ),
              ),
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}