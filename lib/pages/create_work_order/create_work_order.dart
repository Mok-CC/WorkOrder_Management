import 'package:flutter/material.dart';

class CreateWorkOrderPage extends StatefulWidget {
  const CreateWorkOrderPage({super.key});

  @override
  _CreateWorkOrderPageState createState() => _CreateWorkOrderPageState();
}

class _CreateWorkOrderPageState extends State<CreateWorkOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _applicableRoles = [
    'Admin',
    'Manager',
    'Engineer',
    'Operator'
  ];
  final List<String> _selectedRoles = [];
  final List<String> _uploadedFiles = [];
  final int _maxVisibleChips = 2; // 最多显示的 Chip 数量

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff33875c6),
        title: Center(
          child: Text(
            'Work Order Management',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.white),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 表单区域
              _buildFormSection(),
              SizedBox(height: 24),
              // 附件区域
              _buildAttachmentsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Work Order Title',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          // 选择工单标题
          items: ['Title 1', 'Title 2', 'Title 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'Select Work Order Title',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Text('Handle',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          // 选择处理人
          items: ['Handle 1', 'Handle 2', 'Handle 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'Select Handle',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text('Applicable Roles',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(width: 5), // 添加一些间距

            Tooltip(
              message:
                  'Once associated, users without folder permissions can view and follow up on this order in the [Shared orders] list. Additionally, any modifications to the ticket will trigger notifications (including WeCom) to the users specified in this field.',
              height: 162,
              triggerMode: TooltipTriggerMode.tap,
              padding: EdgeInsets.all(0),
              preferBelow: false,
              child: Icon(Icons.help_outline, size: 15),
            ),
          ],
        ),
        // 自定义下拉选择框
        DropdownButtonFormField<String>(
          items: _applicableRoles.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              enabled: !_selectedRoles.contains(value), // 已选的角色禁用
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null && !_selectedRoles.contains(value)) {
              setState(() {
                _selectedRoles.add(value);
              });
            }
          },
          decoration: InputDecoration(
            hintText: 'Select Applicable Roles',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        // 显示选中的角色
        Wrap(
          spacing: 8,
          runSpacing: 8, // 控制行间距
          children: _selectedRoles
              .take(_maxVisibleChips) // 限制显示的 Chip 数量
              .map((role) => Chip(
                    label: Text(role),
                    onDeleted: () {
                      setState(() {
                        _selectedRoles.remove(role);
                      });
                    },
                  ))
              .toList()
            ..addIf(
              _selectedRoles.length > _maxVisibleChips,
              Chip(
                label: Text('+${_selectedRoles.length - _maxVisibleChips}'),
                backgroundColor: Colors.grey[300],
              ),
            ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text('Applcation Users',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            SizedBox(width: 5), // 添加一些间距
            Tooltip(
              message:
                  'Once associated, users without folder permissions can view and follow up on this order in the [Shared orders] list. Additionally, any modifications to the ticket will trigger notifications (including WeCom) to the users specified in this field.',
              height: 162,
              triggerMode: TooltipTriggerMode.tap,
              padding: EdgeInsets.all(0),
              preferBelow: false,
              child: Icon(Icons.help_outline, size: 15),
            ),
          ],
        ),

        DropdownButtonFormField<String>(
          // 选择适用用户
          items: ['User 1', 'User 2', 'User 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: 'Select Applicable Users',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        Text('Description',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Enter Description',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Attachments',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // 模拟文件上传
            setState(() {
              _uploadedFiles.add('file_${_uploadedFiles.length + 1}.pdf');
            });
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload, color: Colors.blue),
                SizedBox(width: 8),
                Text('Click to upload', style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        if (_uploadedFiles.isNotEmpty)
          Column(
            children: _uploadedFiles.map((file) {
              return ListTile(
                leading: Icon(
                  Icons.picture_as_pdf_rounded,
                  color: Colors.deepOrangeAccent,
                ),
                title: Text(file),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.download, color: Colors.blue),
                      onPressed: () {
                        // 下载文件逻辑
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _uploadedFiles.remove(file);
                        });
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

// 扩展 List，添加条件添加元素的方法
extension ListExtension<T> on List<T> {
  void addIf(bool condition, T element) {
    if (condition) {
      add(element);
    }
  }
}
