import 'package:flutter/material.dart';
import 'package:work_order/pages/create_work_order/create_work_order.dart';
import 'package:work_order/utils/app_colors.dart';
import 'package:work_order/widgets/bottomsheet.dart';
import 'package:work_order/widgets/breadcrumb.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WorkDepartmentPage extends StatefulWidget {
  const WorkDepartmentPage({super.key});

  @override
  _WorkDepartmentPageState createState() => _WorkDepartmentPageState();
}

class _WorkDepartmentPageState extends State<WorkDepartmentPage> {
  final List<bool> _checkboxValues = List.generate(10, (index) => false);
  bool _isAnyChecked = false; // 是否有选中项
  int _selectedCount = 0; // 选中项数量

  void _updateSelectedCount() {
    setState(() {
      _selectedCount =
          _checkboxValues.where((value) => value).length; // 计算选中项数量
      _isAnyChecked = _selectedCount > 0; // 是否有选中项
    });
  }

  void _onCheckboxChanged(int index, bool? value) {
    setState(() {
      _checkboxValues[index] = value ?? false;
      _updateSelectedCount(); // 更新选中项数量
    });
  }

  // 更多按钮显示底部弹框
  void _showBottomSheet(String title, bool isFolder, String? creationTime,
      String? workOrderNumber, String? handler, onEdit, Function onDelete) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetWidget(
              title: title,
              isFolder: isFolder,
              creationTime: creationTime,
              workOrderNumber: workOrderNumber,
              handler: handler,
              onEdit: onEdit);
          // onDelete: onDelete);
        });
  }

  // 创建文件夹弹框
  void _showCreateFolderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 确保对话框只占用必要的空间
            children: [
              // 标题区域
              Container(
                color: AppColors.tablebackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create Folder',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.articleColor),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // 关闭弹框
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // 内容区域
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '*',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Text(
                          'Folder Name',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.articleColor),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Please select",
                        border: OutlineInputBorder(),
                      ),
                      items: ['John', 'Mike', 'Amy']
                          .map((name) => DropdownMenuItem(
                                value: name,
                                child: Text(name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // 处理名字选择
                      },
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          '*',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Text(
                          'Applicable Roles ',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.articleColor),
                        ),
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
                      decoration: InputDecoration(
                        hintText: "Please select",
                        border: OutlineInputBorder(),
                      ),
                      items: ['Role 1', 'Role 2', 'Role 3']
                          .map((role) => DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // 处理角色选择
                      },
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          '*',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Text(
                          'Applicable Users ',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.articleColor),
                        ),
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
                      decoration: InputDecoration(
                        hintText: "Please select",
                        border: OutlineInputBorder(),
                      ),
                      items: ['User 1', 'User 2', 'User 3']
                          .map((user) => DropdownMenuItem(
                                value: user,
                                child: Text(user),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // 处理用户选择
                      },
                    ),
                    SizedBox(height: 24),
                    // 操作按钮区域
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context); // 关闭弹框
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 25),
                                backgroundColor: AppColors.backgroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17)),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              // 处理提交逻辑
                              Navigator.pop(context); // 关闭弹框
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 25),
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                            child: Text('Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 移动工单弹框
  void _showMoveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 确保对话框只占用必要的空间
            children: [
              // 标题区域
              Container(
                color: AppColors.tablebackgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Move work order',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.articleColor),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // 关闭弹框
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // 内容区域
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          '*',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Text(
                          'Move to',
                          style: TextStyle(
                              fontSize: 16, color: AppColors.articleColor),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Please select",
                        border: OutlineInputBorder(),
                      ),
                      items: ['Folder 1', 'Folder 2', 'Folder 3']
                          .map((name) => DropdownMenuItem(
                                value: name,
                                child: Text(name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // 处理名字选择
                      },
                    ),
                    SizedBox(height: 24),

                    // 操作按钮区域
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context); // 关闭弹框
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 25),
                                backgroundColor: AppColors.backgroundColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17)),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              // 处理提交逻辑
                              Navigator.pop(context); // 关闭弹框
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 25),
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                            child: Text('Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 路由导航面包屑
                Breadcrumb(paths: [
                  'Root directory',
                  'Sales and marketing department'
                ]),
                // 创建工单按钮
                PopupMenuButton<String>(
                  onSelected: (String result) {
                    // 处理点击的菜单项
                    print('Selected: $result');
                  },
                  offset: Offset(0, 40),
                  shape: RoundedRectangleBorder(),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 24,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: null, // 不需要在这里设置 onPressed，PopupMenuButton 会自动处理
                  ),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Operation records',
                      child: Text(
                        'Operation records',
                        style: TextStyle(
                            fontSize: 16, color: AppColors.articleColor),
                      ),
                      // 路由跳转
                      onTap: () {
                        Navigator.pushNamed(context, '/operation_records',
                            arguments: {
                              'title': 'Operation Records',
                            });
                      },
                    ),
                    PopupMenuItem<String>(
                      value: 'Create folder',
                      child: Text(
                        'Create folder',
                        style: TextStyle(
                            fontSize: 16, color: AppColors.articleColor),
                      ),
                      onTap: () {
                        _showCreateFolderDialog(context);
                      },
                    ),
                    PopupMenuItem<String>(
                      value: 'Create work order',
                      child: Text(
                        'Create work order',
                        style: TextStyle(
                            fontSize: 16, color: AppColors.articleColor),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/create_work_order',
                            arguments: {'title': 'Create Work Order'});
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // 工单文件夹
            ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 48),
                child: Icon(
                  Icons.folder,
                  size: 32,
                  color: Colors.cyan,
                ),
              ),
              // 图标
              title: Text(
                'File test',
                style: TextStyle(fontSize: 18),
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  // 处理更多操作
                  _showBottomSheet('File test', true, '2021-10-10 10:10:10',
                      'WO-0001', 'John Doe', () {
                    // 编辑工单
                  }, () {});
                },
              ),
            ),
            Divider(height: 1, thickness: 1, color: Colors.grey), // 分隔线

            // 工单列表
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 0, // 去掉阴影
                        margin: EdgeInsets.zero, // 去掉外边距
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: _checkboxValues[index],
                                  onChanged: (value) {
                                    _onCheckboxChanged(index, value);
                                  }),
                              Icon(
                                Icons.insert_drive_file,
                                color: Colors.blue,
                              ), // 文件图标
                            ],
                          ),
                          title: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'work_detail',
                                  arguments: {
                                    "title": 'Thermo Fisher ${index + 1}',
                                  });
                            },
                            child: Text(
                              'Thermo Fisher ${index + 1}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.more_horiz),
                            onPressed: () {
                              // 处理更多操作
                              _showBottomSheet(
                                'Thermo Fisher ${index + 1}',
                                false,
                                'creationTime',
                                'workOrderNumber',
                                'Mok1',
                                () {
                                  // 编辑工单
                                  Navigator.pushNamed(
                                      context, '/create_work_order',
                                      arguments: {
                                        'title': 'Create Work Order',
                                        'isEdit': true,
                                        'workOrderData': {
                                          'name': 'Thermo Fisher ${index + 1}',
                                          'creationTime': 'creationTime',
                                          'workOrderNumber': 'workOrderNumber',
                                          'handler': 'Mok1',
                                        }
                                      });
                                },
                                () {
                                  // 删除工单
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      // 添加分隔线
                      Divider(
                        height: 1, // 高度，影响分隔线与内容的间距
                        thickness: 1, // 厚度
                        color: Colors.grey, // 颜色
                      ),
                    ],
                  );
                },
              ),
            )),
          ],
        ),
      ),
      // 底部弹框
      bottomSheet: _isAnyChecked
          ? Container(
              height: 72, // 高度72dp
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white.withValues(alpha: 0.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 左边文本
                  Text(
                    '$_selectedCount items selected', // 选中数量
                    style: TextStyle(fontSize: 16),
                  ),
                  // 右边按钮
                  ElevatedButton(
                    onPressed: () {
                      // 处理按钮点击事件
                      _showMoveDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // 蓝色背景
                      fixedSize: Size(156, 48), // 设置按钮大小
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // 圆角6dp
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Move',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16), // 白色文字
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null, // 没有选中项时不显示弹框
    );
  }
}
