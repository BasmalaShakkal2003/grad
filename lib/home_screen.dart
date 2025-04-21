import'package:flutter/material.dart';
import'team_finder_screen.dart';
import'profile_screen.dart';
import'progress_screen.dart';
import'your_group.dart';
import'ai_screen.dart';
import'conversation_screen.dart';
import'notifications_screen.dart';
import'package:intl/intl.dart';

// ---------------------------Home screen-------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TeamFinderScreen()));
    } else if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProgressScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 15),
              _buildCalendarButton(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 380,
                      height: 70,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const YourGroup()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF011226),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.groups_3_sharp,
                                      color: Colors.white, size: 30),
                                  SizedBox(width: 10),
                                  Text(
                                    "Group Members",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontFamily: "Inter"),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 280,
                      height: 55,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF011226),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.library_books_sharp,
                                      color: Colors.white, size: 25),
                                  SizedBox(width: 10),
                                  Text(
                                    "Your Guide",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontFamily: "Inter"),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/github.png',
                            width: 120, height: 40)),
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/documentation.png',
                            width: 170, height: 40)),
                  ],
                ),
              ),
            ],
          ),
          // AI and chat buttons
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AIScreen()));
              },
              child: ClipOval(
                  child: Image.asset('assets/ai.png', width: 80, height: 70)),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConversationScreen()));
              },
              child: ClipOval(
                  child: Image.asset('assets/chat.png', width: 45, height: 65)),
            ),
          ),
          // Notification icon
          Positioned(
            top: 60,
            right: 18,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsScreen()));
              },
              child: Image.asset(
                'assets/notification.png',
                width: 40,
                height: 40,
              ),
            ),
          ),
          const Positioned(
            top: 130,
            left: 35,
            child: Text(
              "Hi \nHabiba Mohamed",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Inter"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF011226),
          borderRadius: BorderRadius.circular(31),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.person_add, 0),
            _navItem(Icons.home, 1),
            _navItem(Icons.check_box, 2),
            _navItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    bool isHighlighted = index == 1;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.all(isHighlighted ? 8 : 0),
        decoration: isHighlighted
            ? const BoxDecoration(
                color: Color(0xFF042C6E),
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        'assets/head.png',
        fit: BoxFit.cover,
      ),
    );
  }

  // Calendar button
  Widget _buildCalendarButton() {
    String currentDate = DateFormat('E, d MMM').format(DateTime.now());
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF011226),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5)
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_today, color: Colors.white),
              const SizedBox(width: 15),
              Text(currentDate,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
