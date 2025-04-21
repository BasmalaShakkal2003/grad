import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:fl_chart/fl_chart.dart';

//------------------------------Your Progress------------------------------
class YourProgress extends StatelessWidget {
  const YourProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> frontEndData = [
      ChartData('Completed', 10, const Color(0xFF011226)),
      ChartData('Remaining', 5, const Color.fromARGB(255, 194, 192, 192)),
    ];

    final List<ChartData> documentationData = [
      ChartData('Completed', 5, const Color(0xFF011226)),
      ChartData('Remaining', 10, const Color.fromARGB(255, 194, 192, 192)),
    ];

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildProgressSection(
                        'Front End',
                        [
                          'Task 1 : 5/5',
                          'Task 2 : 5/10',
                          'Completed: 10/15',
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    _buildCompletionPieChart(frontEndData, 15),
                  ],
                ),
                const Divider(
                  height: 60,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildProgressSection(
                        'Documentation',
                        [
                          'Task 1 : 5/5',
                          'Task 2 : 0/10',
                          'Completed: 5/15',
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    _buildCompletionPieChart(documentationData, 15),
                  ],
                ),
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

// Data model for chart
class ChartData {
  final String category;
  final int value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}
