import 'package:flutter/material.dart';

// ----------------------------Task Screen----------------------------
class TaskScreen extends StatefulWidget {
  final String title;

  const TaskScreen({Key? key, required this.title}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Map<String, String>> tasks = [
    {
      'Task': 'Home Page in frontend',
      'description':
          'Describe statements and visually agreeing home page for the front end.',
      'requirements':
          'Information clubs and modern towns. Use compatible topics, online, and abroad.',
      'Technologies':
          'HTML, CSS, JavaScript for a business framework like React, Vue, and Angular.',
      'Deadline': 'MAP 17.12.201'
    },
  ];

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('Add From Drive pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF041C40),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Add From Drive'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF041C40),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Upload'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF041C40),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Insert link'),
              ),
            ],
          ),
        );
      },
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
          Positioned(
            top: 135,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  task: tasks[index]['Task']!,
                  description: tasks[index]['description']!,
                  requirements: tasks[index]['requirements']!,
                  technologies: tasks[index]['Technologies']!,
                  deadline: tasks[index]['Deadline']!,
                  onUploadPressed: () => _showOptionsDialog(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String task;
  final String description;
  final String requirements;
  final String technologies;
  final String deadline;
  final VoidCallback onUploadPressed;

  const TaskCard({
    required this.task,
    required this.description,
    required this.requirements,
    required this.technologies,
    required this.deadline,
    required this.onUploadPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Task:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(task),
              const SizedBox(height: 5),
              const Text('Description:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(description),
              const SizedBox(height: 5),
              const Text('Requirements:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(requirements),
              const SizedBox(height: 5),
              const Text('Technologies:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(technologies),
              const SizedBox(height: 5),
              const Text('Deadline:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(deadline),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onUploadPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF011226),
                    foregroundColor: Colors.white,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Upload'),
                      SizedBox(width: 8),
                      Icon(Icons.send, size: 18, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
