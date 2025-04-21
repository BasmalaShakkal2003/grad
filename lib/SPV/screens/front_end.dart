import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_navbar.dart';
import 'edit_front_end.dart';
 
import 'add_tasks.dart';
import 'dart:convert';

class FrontEnd extends StatefulWidget {
  final String groupName;
  const FrontEnd({super.key, required this.groupName});

  @override
  _FrontEndState createState() => _FrontEndState();
}

class _FrontEndState extends State<FrontEnd> {
  int _selectedIndex = 1;
  String frontEndData = "Default Front-End Data";
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('${widget.groupName}_frontEndData');
      
      if (jsonString != null && jsonString.isNotEmpty) {
        final taskData = jsonDecode(jsonString);
        setState(() {
          frontEndData = '''
            task: ${taskData['task']}
            description: ${taskData['description']}
            requirements: ${taskData['requirements']}
            technologies: ${taskData['technologies']}
            deadline: ${taskData['deadline']}
            assignee: ${taskData['assignee']}
            grade: ${taskData['grade']}
          ''';
        });
      }
    } catch (e) {
      setState(() {
        frontEndData = "Default Front-End Data";
      });
    }
  }

  Future<void> _navigateToEditScreen() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditFrontEnd(groupName: widget.groupName),
      ),
    );

    if (result == true) {
      await _loadSavedData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task added to ${widget.groupName}")),
      );
    }
  }

  String _getValueFromData(String key, String data) {
    final lines = data.split('\n');
    for (var line in lines) {
      if (line.trim().startsWith('$key:')) {
        return line.trim().substring('$key:'.length).trim();
      }
    }
    return '';
  }

  List<Widget> _getBulletPoints(String text) {
    final points = text.split('-').where((p) => p.trim().isNotEmpty).toList();
    return points
        .map((point) => Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                top: screenHeight * 0.01,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(fontSize: screenWidth * 0.04)),
                  Expanded(
                    child: Text(
                      point.trim(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ))
        .toList();
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
              height: screenHeight * 0.41,
              decoration: BoxDecoration(
                color: const Color(0xFF041C40),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.4 ),
                  bottomRight: Radius.circular(screenWidth * 0.4 ),
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
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTasks(groupName: widget.groupName),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: screenWidth * 0.06,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToEditScreen,
                        child: Image.asset(
                          'assets/icons/edit.png',
                          width: screenWidth * 0.06,
                          height: screenWidth * 0.06,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "Front-End",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        border: Border.all(
                          color: const Color.fromARGB(255, 27, 26, 26),
                          width: screenWidth * 0.005,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: frontEndData == "Default Front-End Data"
                          ? Center(
                              child: Text(
                                "No task created yet",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Task: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: _getValueFromData('task', frontEndData),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  "Description:",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  _getValueFromData('description', frontEndData),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  "Requirements:",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                ..._getBulletPoints(_getValueFromData('requirements', frontEndData)),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  "Technologies:",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                ..._getBulletPoints(_getValueFromData('technologies', frontEndData)),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      "Deadline: ",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      _getValueFromData('deadline', frontEndData),
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      "Assigned to: ",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      _getValueFromData('assignee', frontEndData),
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.02,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: screenWidth * 0.7,
                child: CustomNavBar(
                  selectedIndex: _selectedIndex,
                  onItemTapped: (index) {
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
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}