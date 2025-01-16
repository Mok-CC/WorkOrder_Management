import 'package:flutter/material.dart';

class WorkDropdownTitle extends StatefulWidget {
  final String title;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onchanged;

  const WorkDropdownTitle(
      {super.key,
      required this.title,
      this.value,
      required this.items,
      this.onchanged});

  @override
  WorkDropdownTitleState createState() => WorkDropdownTitleState();
}

class WorkDropdownTitleState extends State<WorkDropdownTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 标题左对齐
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16, // 字体大小为16pt
          ),
        ),
        SizedBox(height: 8), // 下边距
        DropdownButtonFormField<String>(
          value: widget.value,
          hint: Text('Please Select'),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDBDCE0)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: widget.onchanged,
        ),
      ],
    );
  }
}
