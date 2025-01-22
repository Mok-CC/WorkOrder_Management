import 'package:flutter/material.dart';
import 'package:work_order/widgets/custom_appbar.dart';
import 'package:work_order/widgets/upload_file.dart';
import '../../utils/app_colors.dart';

// 创建工单页面
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

  late Map<String, dynamic> _workOrderData;
  late String? _selectedTitle;
  late String? _selectedHandle;
  late String? _selectedApplicableRole;
  late String? _selectedApplicationUser;
  late String? _description;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 在这里获取路由参数
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final isEdit = args?['isEdit'] ?? false;

    if (args != null && isEdit == true) {
      _workOrderData = args['workOrderData'];
      // 初始化表单数据（仅设置存在的字段）
      _selectedTitle = _workOrderData['name']; // 如果存在则赋值，否则为 null
      _selectedHandle = _workOrderData['handler']; // 如果存在则赋值，否则为 null
      _selectedApplicableRole =
          _workOrderData['applicableRole']; // 如果存在则赋值，否则为 null
      _selectedApplicationUser =
          _workOrderData['applicationUser']; // 如果存在则赋值，否则为 null
      _description = _workOrderData['description']; // 如果存在则赋值，否则为 null
      _selectedRoles
          .addAll(_workOrderData['selectedRoles'] ?? []); // 如果存在则赋值，否则为空列表
      _uploadedFiles
          .addAll(_workOrderData['uploadedFiles'] ?? []); // 如果存在则赋值，否则为空列表
    } else {
      _workOrderData = {};
      _selectedTitle = null;
      _selectedHandle = null;
      _selectedApplicableRole = null;
      _selectedApplicationUser = null;
      _description = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'] ?? 'Create Work Order';

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Container(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 表单区域
                _buildFormSection(),
                SizedBox(height: 24),
                // 下载附件区域
                UploadFile(
                  uploadedFiles: _uploadedFiles,
                  onUpload: () {
                    setState(() {
                      _uploadedFiles
                          .add('file_${_uploadedFiles.length + 1}.pdf');
                    });
                  },
                  onDownload: (file) {
                    print('Downloading $file');
                  },
                  onDelete: (file) {
                    setState(() {
                      _uploadedFiles.remove(file);
                    });
                  },
                ),
                SizedBox(
                  height: 56,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // 保存表单数据
                    _workOrderData['title'] = _selectedTitle;
                    _workOrderData['handle'] = _selectedHandle;
                    _workOrderData['applicableRole'] = _selectedApplicableRole;
                    _workOrderData['applicationUser'] =
                        _selectedApplicationUser;
                    _workOrderData['description'] = _description;
                    _workOrderData['selectedRoles'] = _selectedRoles;
                    _workOrderData['uploadedFiles'] = _uploadedFiles;

                    print('Work Order Data: $_workOrderData');
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: Text('Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              Text('Work Order Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          DropdownButtonFormField<String>(
            value: _selectedTitle, // 设置默认值
            items: ['Title 1', 'Title 2', 'Title 3', 'Thermo Fisher 1']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedTitle = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Select Work Order Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              Text('Handle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          DropdownButtonFormField<String>(
            value: _selectedHandle, // 设置默认值
            items: ['Mok1', 'Mok2', 'Mok3'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedHandle = value;
              });
            },
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
            value: _selectedApplicableRole, // 设置默认值
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
                  _selectedApplicableRole = value;
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
            value: _selectedApplicationUser, // 设置默认值
            items: ['User 1', 'User 2', 'User 3'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedApplicationUser = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Select Applicable Users',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Text('Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextFormField(
            initialValue: _description, // 设置默认值
            maxLines: 5,
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter Description',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
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
