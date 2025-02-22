import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:work_order/pages/create_record.dart';
import 'package:work_order/pages/timeline_detail.dart';
import 'package:work_order/pages/work_order.dart';

import 'pages/create_work_order/create_work_order.dart';
import 'pages/operation_records.dart';
import 'pages/work_detail.dart';

void main() {
  debugPaintSizeEnabled = false;
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
      routes: {
        '/': (context) => WorkOrderManagement(),
        '/operation_records': (context) => OperationRecordsPage(),
        '/create_work_order': (context) => CreateWorkOrderPage(),
        '/create_record': (context) => CreateRecordPage(),
        'work_detail': (context) => WorkDetailPage(),
      },
    );
  }
}
