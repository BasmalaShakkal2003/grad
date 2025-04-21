import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../groups_data.dart';
import '../supervisor widgets/calender.dart';
import 'done.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EditFrontEnd extends StatefulWidget {
  final String groupName;
  const EditFrontEnd({
    Key? key,
    required this.groupName,
  }) : super(key: key);
  @override
  _EditFrontEndState createState() => _EditFrontEndState();
}

class _EditFrontEndState extends State<EditFrontEnd> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _technologiesController = TextEditingController();
  final TextEditingController _setGradController = TextEditingController();

  String _selectedDate = "DD/MM/YYYY";
  List<String> assigneeOptions = [];
  String? selectedAssignee;
  bool _showAssigneeDropdown = false;
  late double screenWidth;
  late double screenHeight;

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();
    _technologiesController.dispose();
    _setGradController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    assigneeOptions = _getEmailsFromGroups();
    if (assigneeOptions.isNotEmpty) {
      selectedAssignee = assigneeOptions.first;
    }
  }

  List<String> _getEmailsFromGroups() {
    List<String> emails = [];
    var currentGroup = groups.firstWhere(
      (group) => group['name'] == widget.groupName,
      orElse: () => {'students': []},
    );
    for (var student in currentGroup['students']) {
      if (student['email'] != null) {
        emails.add(student['email']);
      }
    }
    return emails;
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        DateTime currentDate = DateTime.now();
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: screenWidth * 0.8,
            child: MonthPicker(
              selectedDate: currentDate,
              firstDate: DateTime(currentDate.year - 1),
              lastDate: DateTime(currentDate.year + 1),
              onChanged: (date) => Navigator.pop(context, date),
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
              width: screenWidth * 1.2,
              height: screenHeight * 0.41,
              decoration: BoxDecoration(
                color: const Color(0xFF041C40),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.4),
                  bottomRight: Radius.circular(screenWidth * 0.4),
                ),
              ),
            ),),
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

          // Back Arrow
          Positioned(
            top: MediaQuery.of(context).padding.top + screenHeight * 0.05,
            left: screenWidth * 0.04,
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
                "Front-End ",
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Scrollable Content
          Positioned(
            top: screenHeight * 0.22,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFieldLabel("Task:"),
                  _buildCustomTextField(_taskController, 0.8, 0.04),
                  SizedBox(height: screenHeight * 0.02),

                  _buildFieldLabel("Description:"),
                  _buildCustomTextField(_descriptionController, 0.9, 0.1),
                  SizedBox(height: screenHeight * 0.02),

                  _buildFieldLabel("Requirements:"),
                  _buildCustomTextField(_requirementsController, 0.9, 0.12),
                  SizedBox(height: screenHeight * 0.02),

                  _buildFieldLabel("Technologies:"),
                  _buildCustomTextField(_technologiesController, 0.7, 0.06),
                  SizedBox(height: screenHeight * 0.02),

                  _buildDeadlineSection(),
                  SizedBox(height: screenHeight * 0.02),

                  _buildFieldLabel("Assignees:"),
                  _buildAssigneeDropdown(),
                  SizedBox(height: screenHeight * 0.02),

                  _buildFieldLabel("Set Grade"),
                  _buildCustomTextField(_setGradController, 0.4, 0.04),
                  SizedBox(height: screenHeight * 0.04),

                  // Create Button
                  Center(
                    child: Container(
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: const Color(0xFF011226),
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: ElevatedButton(
                        onPressed: _saveTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          ),
                        ),
                        child: Text(
                          "Create",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.01),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          fontSize: screenWidth * 0.04,
          color: const Color(0xFF041C40),
        ),
      ),
    );
  }

  Widget _buildCustomTextField(
      TextEditingController controller, double widthRatio, double heightRatio) {
    return Container(
      width: screenWidth * widthRatio,
      height: screenHeight * heightRatio,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(screenWidth * 0.01),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.02),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(fontSize: screenWidth * 0.035),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: screenHeight * 0.01),
          ),
        ),
      ),
    );
  }

  Widget _buildDeadlineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Deadline:",
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF041C40),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            GestureDetector(
              onTap: () => _pickDate(context),
              child: Icon(
                Icons.calendar_today,
                size: screenWidth * 0.05,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: screenWidth * 0.4,
          height: screenHeight * 0.04,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(screenWidth * 0.01),
          ),
          child: Center(
            child: Text(
              _selectedDate,
              style: TextStyle(fontSize: screenWidth * 0.035),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssigneeDropdown() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _showAssigneeDropdown = !_showAssigneeDropdown),
          child: Container(
            width: screenWidth * 0.4,
            height: screenHeight * 0.04,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.02),
                    child: Text(
                      selectedAssignee ?? '',
                      style: TextStyle(fontSize: screenWidth * 0.035),
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, size: screenWidth * 0.05),
              ],
            ),
          ),
        ),
        if (_showAssigneeDropdown)
          Container(
            width: screenWidth * 0.5,
            height: screenHeight * 0.2,
            margin: EdgeInsets.only(top: screenHeight * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              itemCount: assigneeOptions.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),
              itemBuilder: (context, index) => ListTile(
                dense: true,
                visualDensity: VisualDensity.compact,
                title: Text(
                  assigneeOptions[index],
                  style: TextStyle(fontSize: screenWidth * 0.035),
                ),
                onTap: () {
                  setState(() {
                    selectedAssignee = assigneeOptions[index];
                    _showAssigneeDropdown = false;
                  });
                },
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _saveTask() async {
    if (_taskController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task name is required")),
      );
      return;
    }

    try {
      final taskData = {
        'task': _taskController.text,
        'description': _descriptionController.text,
        'requirements': _requirementsController.text,
        'technologies': _technologiesController.text,
        'deadline': _selectedDate,
        'assignee': selectedAssignee,
        'grade': _setGradController.text,
        'group': widget.groupName,
        'type': 'Front-End',
        'createdAt': DateTime.now().toString(),
      };

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('${widget.groupName}_frontEndData', jsonEncode(taskData));

      final groupIndex = groups.indexWhere((g) => g["name"] == widget.groupName);
      if (groupIndex != -1) {
        groups[groupIndex]["tasks"] ??= [];
        groups[groupIndex]["tasks"].add(taskData);
      }

      final shouldReturn = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => DoneScreen(
            groupName: widget.groupName,
            taskData: taskData,
          ),
        ),
      );

      if (shouldReturn == true && context.mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving task: ${e.toString()}")),
        );
      }
    }
  }
}