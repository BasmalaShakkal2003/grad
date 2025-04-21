import 'package:flutter/material.dart';
import '../profile_data.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background layers
          Positioned(
            top: -screenSize.height * 0.2,
            left: 0,
            right: 0,
            child: Container(
              height: screenSize.height * 0.42,
              decoration: BoxDecoration(
                color: const Color(0xFF041C40),
                borderRadius: BorderRadius.circular(screenSize.width * 0.2),
              ),
            ),
          ),
          Positioned(
            top: -screenSize.height * 0.15,
            left: -screenSize.width * 0.05,
            right: -screenSize.width * 0.05,
            child: Container(
              height: screenSize.height * 0.25,
              decoration: BoxDecoration(
                color: const Color(0xFF011226),
                borderRadius: BorderRadius.circular(screenSize.width * 0.3),
              ),
            ),
          ),

          // Profile Picture
          Positioned(
            top: screenSize.height * 0.06,
            right: screenSize.width * 0.05,
            child: CircleAvatar(
              radius: screenSize.width * 0.07,
              backgroundImage: AssetImage(
                profileData["Profile Image"] ?? 'assets/profile.png',
              ),
            ),
          ),

          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.06,
                      vertical: screenSize.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Dr/ ",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                profileData["Full Name"] ?? "Unknown",
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Calendar Box
                  ResponsiveCalendar(screenSize: screenSize),

                  SizedBox(height: screenSize.height * 0.05),

                  // Notifications Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: screenSize.height * 0.1,
                      decoration: BoxDecoration(
                        color: const Color(0xFF011226),
                        borderRadius: BorderRadius.circular(screenSize.width * 0.04),
                        border: Border.all(color: Colors.white24, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: screenSize.width * 0.05),
                            child: Text(
                              "Notifications",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.width * 0.05,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenSize.width * 0.05),
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: screenSize.width * 0.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenSize.height * 0.02),

                  // Notification List
                  ResponsiveNotificationsList(screenSize: screenSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveCalendar extends StatelessWidget {
  final Size screenSize;

  const ResponsiveCalendar({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
      alignment: Alignment.centerLeft,  
      child: Container(
        width: screenSize.width * 0.52,
        height: screenSize.height * 0.06,
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.01,
          vertical: screenSize.height * 0.005,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF011226),
          borderRadius: BorderRadius.circular(screenSize.width * 0.06),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,  
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: screenSize.width * 0.06,
                ),
                SizedBox(width: screenSize.width * 0.02),
                Text(
                  DateFormat('E, d MMM').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(width: screenSize.width * 0.09),  
            Container(
              width: screenSize.width * 0.1,
              height: screenSize.width * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenSize.width * 0.04),
              ),
              child: Center(
                child: Text(
                  DateTime.now().year.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveNotificationsList extends StatelessWidget {
  final Size screenSize;

  const ResponsiveNotificationsList({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      "GradEase Send you a proposal",
      "Habiba Mohamed submitted task 1 ",
      "1 message from GradEase group",
      "GradEase added a new note",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: screenSize.height * 0.1,
            margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
            decoration: BoxDecoration(
              color: const Color(0xABD9D9D9),
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(screenSize.width * 0.02),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenSize.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notifications[index],
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: screenSize.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (index == 0) 
                    ResponsiveActionButtons(screenSize: screenSize)
                  else
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: screenSize.width * 0.3,
                        height: screenSize.height * 0.03,
                        decoration: BoxDecoration(
                          color: const Color(0xFF041C40),
                          borderRadius: BorderRadius.circular(screenSize.width * 0.06),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenSize.width * 0.06),
                            ),
                          ),
                          child: Text(
                            index == 1 ? "See details" : "View",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenSize.width * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ResponsiveActionButtons extends StatelessWidget {
  final Size screenSize;

  const ResponsiveActionButtons({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ["Reject", "Accept", "View"].map((label) {
        return Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
            height: screenSize.height * 0.03,
            decoration: BoxDecoration(
              color: const Color(0xFF041C40),
              borderRadius: BorderRadius.circular(screenSize.width * 0.06),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.06),
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.width * 0.03,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}