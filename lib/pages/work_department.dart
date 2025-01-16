import 'package:flutter/material.dart';
import 'package:work_order/utils/app_colors.dart';
import 'package:work_order/widgets/bottomsheet.dart';
import 'package:work_order/widgets/breadcrumb.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WorkDepartmentPage extends StatefulWidget {
  @override
  _WorkDepartmentPageState createState() => _WorkDepartmentPageState();
}

class _WorkDepartmentPageState extends State<WorkDepartmentPage> {
  final List<bool> _checkboxValues = List.generate(10, (index) => false);
  final popoverController = ShadPopoverController();
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
              onEdit: () => onEdit,
              onDelete: () => onDelete);
        });
  }

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
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
                        onPressed:
                            null, // 不需要在这里设置 onPressed，PopupMenuButton 会自动处理
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
                            Navigator.pushNamed(context, '/operation_records');
                          },
                        ),
                        PopupMenuItem<String>(
                          value: 'Create folder',
                          child: Text(
                            'Create folder',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.articleColor),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Create work order',
                          child: Text(
                            'Create work order',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.articleColor),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/create_work_order');
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
                      }, () {
                        // 删除工单
                      });
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
                              title: Text(
                                'Thermo Fisher ${index + 1}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                                    'handler',
                                    () {
                                      // 编辑工单
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
          )),
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

class PopoverContent extends StatelessWidget {
  const PopoverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            ' Operation records',
            style: TextStyle(fontSize: 14),
          ),
          onTap: () {
            Navigator.pop(context); // 关闭气泡
            print('Option 1 clicked');
          },
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey),
        ListTile(
          title: Text(
            'Create folder',
            style: TextStyle(fontSize: 14),
          ),
          onTap: () {
            Navigator.pop(context); // 关闭气泡
            print('Option 2 clicked');
          },
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey),
        ListTile(
          title: Text(
            'Create work order',
            style: TextStyle(fontSize: 14),
          ),
          onTap: () {
            Navigator.pop(context); // 关闭气泡
            print('Option 3 clicked');
          },
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey),
      ],
    );
  }
}
