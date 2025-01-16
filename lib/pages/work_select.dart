import 'package:flutter/material.dart';

import 'work_dropdown_title.dart';

class WorkSelect extends StatefulWidget {
  @override
  _WorkSelectState createState() => _WorkSelectState();
}

class _WorkSelectState extends State<WorkSelect> {
  bool _isExpanded = false; // 控制展开/收起状态
  String? _selectedValue1; // 选择框 1 的值
  String? _selectedValue2; // 选择框 2 的值
  String? _selectedValue3; // 选择框 3 的值

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WorkDropdownTitle(
            title: 'Ticket title',
            value: _selectedValue1,
            items: <String>['Option A', 'Option B', 'Option C'],
            onchanged: (value) => {
              setState(() {
                _selectedValue1 = value;
              }),
            },
          ),
          if (_isExpanded) ...[
            SizedBox(height: 16),
            WorkDropdownTitle(
              title: 'Status',
              value: _selectedValue2,
              items: ['Option X', 'Option Y', 'Option Z'],
              onchanged: (value) => {
                setState(() {
                  _selectedValue2 = value;
                }),
              },
            ),
            SizedBox(height: 16),
            WorkDropdownTitle(
              title: 'Processor',
              value: _selectedValue3,
              items: ['Option 1', 'Option 2', 'Option 3'],
              onchanged: (value) => {
                setState(() {
                  _selectedValue3 = value;
                }),
              },
            ),
          ],
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 处理 Reset 按钮点击
                      setState(() {
                        // 重置选择框的值
                        _selectedValue1 = null;
                        _selectedValue2 = null;
                        _selectedValue3 = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // 圆角为6pt
                      ),
                      backgroundColor: Colors.white, // 背景色为白色
                    ),
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.black), // 字体颜色为黑色
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // 处理 Search 按钮点击
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // 圆角为6pt
                      ),
                      backgroundColor:
                          Color(0xFF216BF0).withOpacity(0.1), // 背景色
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(color: Color(0xFF216BF0)),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded; // 切换展开/收起状态
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
