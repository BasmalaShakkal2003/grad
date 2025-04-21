// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'team_finder_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import 'home_screen.dart';
import 'add_member_screen.dart';
import 'group_members_provider.dart';

class YourGroup extends StatefulWidget {
  const YourGroup({super.key});

  @override
  _YourGroupState createState() => _YourGroupState();
}

class _YourGroupState extends State<YourGroup> {
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TeamFinderScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProgressScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<GroupMembersProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: membersProvider.members.length,
              itemBuilder: (context, index) {
                final member = membersProvider.members[index];
                return YourGroupcard(
                  name: member['name'] ?? '',
                  id: member['id'] ?? '',
                  phone: member['phone'] ?? '',
                  email: member['email'] ?? '',
                  onDelete: () => membersProvider.removeMember(index),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF011226),
          borderRadius: BorderRadius.circular(35),
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

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            'assets/head2.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 70,
            left: 2,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            top: 135,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Group Members",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 70,
            child: IconButton(
              icon: const Icon(Icons.person_add, size: 30, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMemberScreen(),
                  ),
                );
              },
            ),
          ),
        ],
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
}

class YourGroupcard extends StatelessWidget {
  final String name;
  final String id;
  final String phone;
  final String email;
  final VoidCallback onDelete;

  const YourGroupcard({
    Key? key,
    required this.name,
    required this.id,
    required this.phone,
    required this.email,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "inter",
                          ),
                          children: [
                            const TextSpan(
                              text: "Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: name),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "inter",
                          ),
                          children: [
                            const TextSpan(
                              text: "ID: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: id),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "inter",
                          ),
                          children: [
                            const TextSpan(
                              text: "Phone: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: phone),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "inter",
                          ),
                          children: [
                            const TextSpan(
                              text: "Email: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: email),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  color: const Color(0xFF041C40),
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: SizedBox(
                        width: 50, 
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Delete',
                            style: const TextStyle(color: Colors.white,fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'delete') {
                      onDelete();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
