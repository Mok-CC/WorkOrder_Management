import 'package:flutter/material.dart';
import 'package:work_order/pages/timeline_detail.dart';
import 'package:work_order/pages/work_order.dart';

import 'pages/create_work_order/create_work_order.dart';
import 'pages/operation_records.dart';
import 'pages/work_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(),
        useMaterial3: true,
      ),
      home: WorkOrderManagement(),
      routes: {
        '/operation_records': (context) => OperationRecordsPage(),
        '/create_work_order': (context) => CreateWorkOrderPage(),
      },
    );
  }
}
