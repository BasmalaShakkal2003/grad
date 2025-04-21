import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/dropdown.dart';
import 'done.dart';

class AddMeeting extends StatefulWidget {
  final String groupName;

  const AddMeeting({Key? key, required this.groupName}) : super(key: key);

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  
    String selectedDate = '';
  String selectedTime = '';
  String selectedTypeOfMeeting = 'Physical';

  // Method to pick date
  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color.fromARGB(255, 14, 88, 138),
              surface: const Color.fromARGB(255, 3, 20, 45),
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color.fromARGB(255, 3, 20, 45),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              labelLarge: TextStyle(color: Colors.white),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

Future<void> _pickTime(BuildContext context) async {
  int hour = 12;
  int minute = 0;
  String amPm = 'AM';
  TextEditingController hourController = TextEditingController(text: hour.toString().padLeft(2, '0'));
  TextEditingController minuteController = TextEditingController(text: minute.toString().padLeft(2, '0'));

  bool isHourSelected = false;
  bool isMinuteSelected = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Select Time',
          style: TextStyle(color: Colors.white, fontSize: 18),  
        ),
        backgroundColor: const Color(0xFF011226),   
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hour input field
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: hourController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    style: const TextStyle(color: Colors.white, fontSize: 28),  
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'HH',
                      filled: true,
                      fillColor: isHourSelected ? Color(0xFF0F5C8C) : Color(0xFF011226),  
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isMinuteSelected ? Color(0xFF0F5C8C) : Colors.transparent,  
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isHourSelected = true;
                        isMinuteSelected = false;  
                      });
                    },
                    onChanged: (value) {
                     
                      hour = int.tryParse(value) ?? hour;
                      if (hour < 1 || hour > 12) {
                        hour = 12;
                        hourController.text = hour.toString().padLeft(2, '0');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                
                Text(
                  ':',
                  style: TextStyle(color: Colors.white, fontSize: 30),  
                ),
                const SizedBox(width: 5),
                // Minute input field
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: minuteController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    style: const TextStyle(color: Colors.white, fontSize: 28),  
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'MM',
                      filled: true,
                      fillColor: Color(0xFF0F5C8C), 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isMinuteSelected ? Color(0xFF0F5C8C) : Colors.transparent, 
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isMinuteSelected = true;
                        isHourSelected = false;  
                      });
                    },
                    onChanged: (value) {
                      
                      minute = int.tryParse(value) ?? minute;
                      if (minute < 0 || minute > 59) {
                        minute = 0;
                        minuteController.text = minute.toString().padLeft(2, '0');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 25),
                // AM/PM buttons  
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          amPm = 'AM';
                        });
                      },
                      child: Container(
                        width: 54,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: amPm == 'AM' ? Color(0xFF0F5C8C) : Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11),
                            topRight: Radius.circular(11),
                          ),
                        ),
                        child: Text(
                          'AM',
                          style: TextStyle(
                            color: amPm == 'AM' ? Colors.white : Colors.white,  
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          amPm = 'PM';
                        });
                      },
                      child: Container(
                        width: 54,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: amPm == 'PM' ? Colors.white : Colors.transparent, 
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(11),
                            bottomRight: Radius.circular(11),
                          ),
                          border: Border.all(
                            color: amPm == 'PM' ? Colors.white : Colors.white,  
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'PM',
                          style: TextStyle(
                            color: amPm == 'PM' ? Colors.black : Colors.white,  
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF0F5C8C), fontSize: 16),  
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedTime = "$hour:${minute.toString().padLeft(2, '0')} $amPm";
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: Color(0xFF0F5C8C), fontSize: 16),  
            ),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final scaleFactor = mediaQuery.textScaleFactor.clamp(0.8, 1.2);

    return MediaQuery(
      data: mediaQuery.copyWith(textScaleFactor: scaleFactor),
      child: Builder(
        builder: (context) {
          final scaleW = screenWidth / 392; 
          final scaleH = screenHeight / 852;  
          double scale(double value) => value * scaleW;
          double scaleV(double value) => value * scaleH;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                // Base Layer
                Positioned(
                  top: -scaleV(170),
                  left: -scale(30),
                  right: -scale(30),
                  child: Container(
                    width: scale(487),
                    height: scaleV(361),
                    decoration: BoxDecoration(
                      color: const Color(0xFF041C40),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(scale(150)),
                        bottomRight: Radius.circular(scale(150)),
                      ),
                    ),
                  ),
                ),

                // Overlay Layer
                Positioned(
                  top: -scaleV(137.93),
                  left: -scale(40),
                  right: -scale(40),
                  child: Container(
                    width: scale(487),
                    height: scaleV(208.94),
                    decoration: BoxDecoration(
                      color: const Color(0xFF011226),
                      borderRadius: BorderRadius.circular(scale(113)),
                    ),
                  ),
                ),

                // Back Arrow
                Positioned(
                  top: scaleV(91),
                  left: scale(10),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: scale(26),
                      color: Colors.white,
                    ),
                  ),
                ),

                // Title
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: scaleV(135)),
                    child: const Text(
                      "Meeting",
                      style: TextStyle(
                        fontFamily: 'Source Sans Pro',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Input Fields Area
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: scaleV(180),
                      left: scale(20),
                      right: scale(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildResponsiveField(
                                  context,
                                  "Date of meeting",
                                  controller: TextEditingController(text: selectedDate),
                                  onArrowTap: () => _pickDate(context),
                                  scale: scale,
                                  scaleV: scaleV,
                                ),
                                SizedBox(height: scaleV(15)),
                                _buildResponsiveField(
                                  context,
                                  "Meeting time",
                                  controller: TextEditingController(text: selectedTime),
                                  onArrowTap: () => _pickTime(context),
                                  scale: scale,
                                  scaleV: scaleV,
                                ),
                                SizedBox(height: scaleV(15)),
                                Transform.scale(
                                  scale: scale(1),
                                  child: CustomDropdownField(
                                    label: "  Type of meeting",
                                    value: selectedTypeOfMeeting,
                                    items: ['Physical', 'Online'],
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedTypeOfMeeting = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: scaleV(15)),
                                _buildResponsiveField(
                                  context,
                                  "Additional information", 
                                  maxLines: 3,
                                  scale: scale,
                                  scaleV: scaleV,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: scaleV(20)),
                        SizedBox(
                          width: scale(149),
                          height: scaleV(47),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF041C40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(scale(18)),
                              ),
                            ),
                            onPressed: () {
                              final taskData = {
                                'date': selectedDate,
                                'time': selectedTime,
                                'type': selectedTypeOfMeeting,
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoneScreen(
                                    groupName: widget.groupName,
                                    taskData: taskData,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: scale(25),
                                color: Colors.white,
                            ),
                          ),
                        ),),
                        SizedBox(height: scaleV(100)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResponsiveField(
    BuildContext context,
    String label, {
    int maxLines = 1,
    VoidCallback? onArrowTap,
    TextEditingController? controller,
    required double Function(double) scale,
    required double Function(double) scaleV,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: scale(20),
                color: const Color(0xFF041C40),
              ),
            ),
            if (onArrowTap != null)
              GestureDetector(
                onTap: onArrowTap,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF041C40),
                  size: scale(24),
                ),
              ),
          ],
        ),
        SizedBox(height: scaleV(8)),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(scale(12)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 137, 136, 136).withOpacity(0.3),
                spreadRadius: scale(2),
                blurRadius: scale(8),
                offset: Offset(0, scaleV(4)),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            readOnly: onArrowTap != null,
            maxLines: maxLines,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: scale(16),
                vertical: scaleV(14)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(scale(12)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 214, 211, 211),
            ),
            style: TextStyle(fontSize: scale(18)),
          ),
        ),
      ],
    );
  }
}