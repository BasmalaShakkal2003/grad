import 'package:flutter/material.dart';
import 'group_details_screen.dart';
import 'meeting_one.dart';
import 'attendance_progress.dart';

class NoteModel {
  final String day;
  final String date;
  final String title;
  final String author;
  final String time;
  final String meetingType;

  NoteModel({
    required this.day,
    required this.date,
    required this.title,
    required this.author,
    required this.time,
    required this.meetingType,
  });
}

// Then define your Note widget class
class Note extends StatefulWidget {
  final String groupName;
  const Note({Key? key, required this.groupName}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final List<NoteModel> _notes = [
    NoteModel(
      day: "MON",
      date: "24",
      title: "One",
      author: "Written by Habiba Nasser",
      time: "At 2:94",
      meetingType: "Online",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
     
    return Scaffold(
      body: Stack(
        children: [
          // Top Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Progress Icon
          Positioned(
            top: screenHeight * 0.13,
            right: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceProgress(
                      groupName: widget.groupName,
                    ),
                  ),
                );
              },
              child: Image.asset(
                "assets/progress.png",
                width: screenWidth * 0.1,
              ),
            ),
          ),

          // Bottom Background Image
          Positioned(
            bottom: -screenHeight * 0.06,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/bgd.png",
              fit: BoxFit.cover,
              height: screenHeight * 0.3,
            ),
          ),

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + screenHeight * 0.01,
            left: screenWidth * 0.04,
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  size: screenWidth * 0.08, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupDetailsScreen(
                      groupName: widget.groupName,
                      members: 0,
                    ),
                  ),
                );
              },
            ),
          ),

          // Title
          Positioned(
            top: screenHeight * 0.13,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Notes",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Content Area
          Positioned(
            top: MediaQuery.of(context).padding.top + screenHeight * 0.15,
            bottom: screenHeight * 0.1,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return _buildNoteCard(_notes[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(NoteModel note, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeetingOne(note: note),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.15,
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(screenWidth * 0.15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        note.day,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        note.date,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.07),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Meeting: ${note.title}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          note.author,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF50555C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.015,
              right: screenWidth * 0.05,
              child: Text(
                note.time,
                style: TextStyle(
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}