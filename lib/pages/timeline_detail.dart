import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

// 时间线详情页
class TimelineWithDetails extends StatelessWidget {
  final List<Map<String, dynamic>> steps = [
    {
      "stepTitle": "2024-08-12",
      "followUpPerson": "Mok",
      "followUpDate": "2024-06-24",
      "details": {
        "recordNumber": "RCyyyymmdd00000",
        "description":
            "Reporting Work Order No.WKT-20241016-001, We Have Encountered A Server Outage Issue...",
        "additionalInfo": "Project Documentation - Meeting Minutes"
      }
    },
    {
      "stepTitle": "2024-08-11",
      "followUpPerson": "Mok",
      "followUpDate": "2024-06-24",
      "details": {
        "recordNumber": "RCyyyymmdd00001",
        "description": "Project Documentation - Meeting Minutes",
        "additionalInfo": "Follow-Up Content"
      }
    },
    {
      "stepTitle": "2024-08-10",
      "followUpPerson": "Mok",
      "followUpDate": "2024-06-24",
      "details": {
        "recordNumber": "RCyyyymmdd00002",
        "description": "Project Documentation - Meeting Minutes",
        "additionalInfo": "Follow-Up Content"
      }
    }
  ];

  TimelineWithDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: steps.map((step) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline
            SizedBox(
              width: 30,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 线
                  Container(
                    width: 1,
                    height: 300,
                    color: Color(0xFFEAEBF2),
                  ),
                  // 圆
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 59,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Arrow
                  // CustomPaint(
                  //   size: Size(20, 20),
                  //   painter: TrianglePainter(),
                  // ),
                  // Step Title
                  Text(
                    'Record Number: ${step['details']['recordNumber']}',
                    style: TextStyle(
                        color: Color(0xFF95969A),
                        fontSize: 15,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 16),
                  // Content
                  Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step Title with two small dots
                          Row(
                            children: [
                              Text(
                                '${step['stepTitle']} ${Jiffy.parse(step['stepTitle']).format(pattern: 'EEE')}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                    color: Color(0xFF216BF0),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                      color: Color(0xFF216BF0)),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Follow-Up: ${step['followUpPerson']}'),
                          SizedBox(height: 16),
                          Text('Date: ${step['followUpDate']}'),
                          SizedBox(height: 16),
                          Text(step['details']['description']),
                          SizedBox(height: 16),
                          Text(step['details']['additionalInfo']),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// Custom Painter for Triangle Arrow
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
