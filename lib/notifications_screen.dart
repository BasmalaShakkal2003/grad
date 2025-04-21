import 'package:flutter/material.dart';

//--------------------Notification screen-----------------------
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/bg.png',
                  fit: BoxFit.cover,
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
                    "Notifications",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.all(16), children: const [
              NotificationCard(
                  message: 'Dr. Mohamed Hassan accepted your proposal'),
            ]),
          ),
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/bgd.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

// Notification card widget
class NotificationCard extends StatelessWidget {
  final String message;
  const NotificationCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/SUPERVISOR.png'),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "inter",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
