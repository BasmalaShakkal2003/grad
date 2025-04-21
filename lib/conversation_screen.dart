import 'package:flutter/material.dart';
import'notes_screen.dart';
import'dr_chat_screen.dart';
import'group_chat_screen.dart';

// -------------------------Conversation Screen----------------------
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 180,
              child: Image.asset(
                'assets/bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Conversations",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              height: 180,
              child: Image.asset(
                'assets/bgd.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: CustomIconButton(
                      color: const Color(0xFF041C40),
                      text: "Notes",
                      icon: Icons.note_add,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: CustomIconButton(
                      color: const Color(0xFF041C40),
                      text: "Chat With Your Group",
                      icon: Icons.chat_sharp,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GroupChatScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: CustomIconButton(
                      color: const Color(0xFF041C40),
                      text: "Chat With Your Supervisor",
                      icon: Icons.chat_sharp,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DRChatScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Button with Icon
class CustomIconButton extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;
  final double iconSize;

  const CustomIconButton({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 19, fontFamily: "inter", fontWeight: FontWeight.bold),
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          )
        ],
      ),
    );
  }
}
