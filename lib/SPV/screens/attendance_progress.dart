import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
 

class AttendanceProgress extends StatelessWidget {
  final String groupName;

  const AttendanceProgress({Key? key, required this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final attendanceData = [
      _Attendance('Enas Hatem', 1),
      _Attendance('Habiba Nasser', 3),
      _Attendance('Habiba Mohamed', 4),
      _Attendance('mariam ibrahim', 2),
   
    ];


    return Scaffold(
      body: Stack(
        children: [
         // Top Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/bg.png",
              fit: BoxFit.cover,
               
            ),
          ),

          // Bottom Background Image
          Positioned(
            bottom: -screenHeight * 0.05,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/bgd.png",
              fit: BoxFit.cover,
              
            ),
          ),

          // Back Arrow Button
          Positioned(
            top: MediaQuery.of(context).padding.top + screenHeight * 0.02,
            left: screenWidth * 0.03,
            child: IconButton(
              icon: Icon(Icons.arrow_back, 
                color: Colors.white, 
                size: screenWidth * 0.08
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Title
          Positioned(
            top: MediaQuery.of(context).padding.top + screenHeight * 0.08,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Attendance Progress",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),


          // Updated Chart Container
          Positioned(
            top: screenHeight * 0.25,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            bottom: screenHeight * 0.25,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.01),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              
             child: BarChart(
  BarChartData(
    alignment: BarChartAlignment.spaceAround,
    maxY: 4,
    minY: 0,
    barTouchData: BarTouchData(enabled: false),
    groupsSpace: screenWidth * 0.03,
    titlesData: FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.black,
              ),
            );
          },
          reservedSize: screenWidth * 0.1,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            int index = value.toInt();
            if (index >= 0 && index < attendanceData.length) {
              return Transform.rotate(
                angle: -1.2,
                child: Text(
                  attendanceData[index].student,
                  style: TextStyle(
                    fontSize: screenWidth * 0.031,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          reservedSize: screenWidth * 0.3, // Increase this value to add more space
        ),
      ),
      rightTitles: AxisTitles(),
      topTitles: AxisTitles(),
    ),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: false,
    ),
    borderData: FlBorderData(
      show: true,
      border: const Border(
        left: BorderSide(color: Colors.black, width: 1),
        bottom: BorderSide(color: Colors.black, width: 1),
      ),
    ),
    barGroups: attendanceData.mapIndexed((index, data) => BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: data.sessions.toDouble(),
          width: screenWidth * 0.15,
          color: const Color(0xFF001C30),
          borderRadius: BorderRadius.circular(6),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 4,
            color: Colors.grey[200],
          ),
        ),
      ],
    )).toList(),
  ),
),

              
              ),
            ),
      

          // Number of meetings label
        Positioned(
  top: screenHeight * 0.22,
  left: screenWidth * 0.01,
  child: Text(
    'Number of meetings',
    style: TextStyle(
      fontSize: screenWidth * 0.035,
      color: Colors.black,
    ),
  ),
),

        ],
      ),
    );
  }
}

class _Attendance {
  final String student;
  final int sessions;

  _Attendance(this.student, this.sessions);
}

extension MapIndexed<T> on List<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) sync* {
    for (var index = 0; index < length; index++) {
      yield f(index, this[index]);
    }
  }
}