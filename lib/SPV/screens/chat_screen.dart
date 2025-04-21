import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final String groupName;

  const ChatScreen({super.key, required this.groupName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [];
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  void saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_messages_${widget.groupName}', jsonEncode(messages));
  }

  Future<void> loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedMessages = prefs.getString('chat_messages_${widget.groupName}');

    if (storedMessages != null) {
      List<Map<String, String>> loadedMessages = List<Map<String, String>>.from(
        jsonDecode(storedMessages).map((msg) => Map<String, String>.from(msg))
      );

      setState(() {
        messages = loadedMessages;
      });
    }
  }

  void sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "sender": "Doctor",
        "message": _messageController.text.trim(),
      });
      saveMessages();
    });

    _messageController.clear();
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

          // Back Button
          Positioned(
            top: screenHeight * 0.099,
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

          // Group Header
          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    child: Image.asset(
                      'assets/chat.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Flexible(
                  child: Text(
                    widget.groupName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat Content
          Positioned.fill(
            top: screenHeight * 0.2,
            bottom:0,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isDoctor = messages[index]['sender'] == "Doctor";
                      return Align(
                        alignment: isDoctor ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.03,
                          ),
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          decoration: BoxDecoration(
                            color: isDoctor
                                ? const Color(0xFF093754)
                                : const Color(0xFF9E9C9C),
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Text(
                            messages[index]['message']!,
                            style: TextStyle(
                              color: isDoctor ? Colors.white : Colors.black,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.01,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBDBDB),
                    border: Border(
                      top: BorderSide(color: Colors.black26, width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            border: Border.all(color: Colors.black26),
                          ),
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: -0.5,
                          child: Icon(
                            Icons.send,
                            size: screenWidth * 0.06,
                            color: const Color(0xFF0F5C8C),
                          ),
                        ),
                        onPressed: sendMessage,
                      ),
                    ],
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