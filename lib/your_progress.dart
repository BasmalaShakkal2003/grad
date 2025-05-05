import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Tracker',
      theme: ThemeData(
        fontFamily: 'Source Serif 4',
      ),
      home: YourProgress(),
    );
  }
}

class ProgressSection {
  final String title;
  final List<String> tasks;
  final int completed;
  final int total;
  final Color completedColor;
  final Color remainingColor;

  ProgressSection({
    required this.title,
    required this.tasks,
    required this.completed,
    required this.total,
    this.completedColor = const Color(0xFF011226),
    this.remainingColor = const Color.fromARGB(255, 194, 192, 192),
  });
}

class ChartData {
  final String category;
  final int value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

class YourProgress extends StatelessWidget {
  YourProgress({super.key});

  // Define your dynamic data here
  final List<ProgressSection> progressSections = [
    ProgressSection(
      title: 'Front End',
      tasks: [
        'Task 1 : 5/5',
        'Task 2 : 5/10',
        'Completed: 10/15',
      ],
      completed: 10,
      total: 15,
    ),
    ProgressSection(
      title: 'Documentation',
      tasks: [
        'Task 1 : 5/5',
        'Task 2 : 0/10',
        'Completed: 5/15',
      ],
      completed: 5,
      total: 15,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < progressSections.length; i++) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildProgressSection(
                          progressSections[i].title,
                          progressSections[i].tasks,
                        ),
                      ),
                      const SizedBox(width: 20),
                      _buildCompletionPieChart(
                        [
                          ChartData('Completed', progressSections[i].completed, 
                              progressSections[i].completedColor),
                          ChartData('Remaining', 
                              progressSections[i].total - progressSections[i].completed, 
                              progressSections[i].remainingColor),
                        ],
                        progressSections[i].total,
                      ),
                    ],
                  ),
                  if (i != progressSections.length - 1)
                    const Divider(
                      height: 60,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: "Source Serif 4",
          ),
        ),
        const SizedBox(height: 16),
        ...items
            .map((item) => Text(
                  item,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontFamily: "Source Serif 4",
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildCompletionPieChart(List<ChartData> data, int total) {
    return SizedBox(
      width: 160,
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: PieChart(
              PieChartData(
                sections: data
                    .map((item) => PieChartSectionData(
                          value: item.value.toDouble(),
                          title: item.category,
                          color: item.color,
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              _buildLegendItem(const Color(0xFF011226), 'Completed'),
              const SizedBox(height: 4),
              _buildLegendItem(
                  const Color.fromARGB(255, 194, 192, 192), 'Remaining'),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
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
                "Your Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}