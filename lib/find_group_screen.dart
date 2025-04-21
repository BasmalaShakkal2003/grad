import 'package:flutter/material.dart';
import'post_screen.dart';
import'team_finder_screen.dart';
import'profile_screen.dart';
import'progress_screen.dart';
import'home_screen.dart';
//-----------------Find Group Screen--------------------------
class CustomDividerWithShadow extends StatelessWidget {
  const CustomDividerWithShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: const Color.fromARGB(255, 189, 188, 188).withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Divider(
        color: Colors.grey[100],
        thickness: 1,
      ),
    );
  }
}

class FindGroupScreen extends StatefulWidget {
  const FindGroupScreen({super.key});

  @override
  _FindGroupScreenState createState() => _FindGroupScreenState();
}

class _FindGroupScreenState extends State<FindGroupScreen> {
  final List<Map<String, String>> groups = [
    {
      'name': 'Mohamed',
      'field': 'Business Technology',
      'description':
          'A smart recycling bin that automatically sorts waste into recyclables and non-recyclables using AI technology.',
      'requirements': 'We need someone to work on AI.'
    },
    {
      'name': 'Ahmed',
      'field': 'Computer Science',
      'description':
          'Developing a mobile app for managing personal finances with AI-based insights.',
      'requirements': 'Looking for a mobile developer.'
    },
  ];

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TeamFinderScreen()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProgressScreen()));
    } else if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GroupCard(
                      name: groups[index]['name']!,
                      field: groups[index]['field']!,
                      description: groups[index]['description']!,
                      requirements: groups[index]['requirements']!,
                    ),
                    if (index < groups.length - 1)
                      const CustomDividerWithShadow(),
                    const SizedBox(height: 20),
                  ],
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
            _navItem(context, Icons.person_add, 0, isHighlighted: true),
            _navItem(context, Icons.home, 1),
            _navItem(context, Icons.check_box, 2),
            _navItem(context, Icons.person, 3),
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
                "Find Group",
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
              icon: const Icon(Icons.edit, size: 23, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PostScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, int index,
      {bool isHighlighted = false}) {
    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Container(
        padding: EdgeInsets.all(isHighlighted ? 8 : 0),
        decoration: isHighlighted
            ? const BoxDecoration(
                color: Color(0xFF042C6E), shape: BoxShape.circle)
            : null,
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String name;
  final String field;
  final String description;
  final String requirements;

  const GroupCard({
    super.key,
    required this.name,
    required this.field,
    required this.description,
    required this.requirements,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/SUPERVISOR.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  field,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Description:',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(description),
        const SizedBox(height: 5),
        const Text(
          'Requirements:',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(requirements),
        const SizedBox(height: 10),
        SizedBox(
          width: 130,
          height: 30,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF011226),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 6),
              minimumSize: const Size(10, 36),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Send Request'),
                SizedBox(width: 5),
                Icon(
                  Icons.person_add,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}