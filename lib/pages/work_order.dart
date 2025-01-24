import 'package:flutter/material.dart';
import 'package:work_order/pages/work_navbar.dart';
import 'package:work_order/pages/work_select.dart';
import 'package:work_order/utils/app_colors.dart';
import 'package:work_order/widgets/custom_appbar.dart';

import 'work_department.dart';

// 首页
class WorkOrderManagement extends StatefulWidget {
  const WorkOrderManagement({super.key});

  @override
  _WorkOrderManagementState createState() => _WorkOrderManagementState();
}

class _WorkOrderManagementState extends State<WorkOrderManagement> {
  bool _isDrawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Work Order Management'),
      // 主体内容
      body: Stack(
        children: [
          // 导航栏和主体内容
          Column(
            children: [
              WorkNavbar(
                  isDrawerOpen: _isDrawerOpen, toggleDrawer: _toggleDrawer),
              Expanded(
                child: Container(
                  color: AppColors.backgroundColor,
                  child: Column(
                    children: [
                      // 选择框
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        margin: const EdgeInsets.all(16),
                        child: WorkSelect(),
                      ),
                      // 工单列表
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: WorkDepartmentPage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // 抽屉部分
          Positioned(
            left: _isDrawerOpen ? 0 : -256,
            top: 0,
            bottom: 0,
            width: 256,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: _isDrawerOpen ? 256 : 0,
              child: Drawer(
                width: 256,
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ExpansionTile(
                          title: Text('Root directory'),
                          children: <Widget>[
                            ListTile(
                              title: Text('Executive office'),
                              onTap: () {
                                _toggleDrawer();
                              },
                            ),
                            ListTile(
                              title: Text('Sales marketing'),
                              onTap: () {
                                _toggleDrawer();
                              },
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Root Menu 2'),
                          children: <Widget>[
                            ListTile(
                              title: Text('Submenu 3'),
                              onTap: () {
                                _toggleDrawer();
                              },
                            ),
                            ListTile(
                              title: Text('Submenu 4'),
                              onTap: () {
                                _toggleDrawer();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 12, // 紧贴右边
                      top: 156, // 适当的顶部间距
                      child: GestureDetector(
                        onTap: _toggleDrawer,
                        child: Container(
                          // 确保 Icon 有一个合适的父组件
                          color: AppColors.backgroundColor,
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
