import 'package:flutter/material.dart';
import 'package:work_order/pages/work_navbar.dart';
import 'package:work_order/pages/work_select.dart';
import 'package:work_order/utils/app_colors.dart';
import 'package:work_order/widgets/custom_appbar.dart';

import 'work_department.dart';

// 首页
class WorkOrderManagement extends StatelessWidget {
  const WorkOrderManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Work Order Management'),
      drawer: Drawer(
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
                        Navigator.pop(context); // 关闭 Drawer
                      },
                    ),
                    ListTile(
                      title: Text('Sales marketing'),
                      onTap: () {
                        Navigator.pop(context); // 关闭 Drawer
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
                        Navigator.pop(context); // 关闭 Drawer
                      },
                    ),
                    ListTile(
                      title: Text('Submenu 4'),
                      onTap: () {
                        Navigator.pop(context); // 关闭 Drawer
                      },
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: -20, // 紧贴右边
              top: 72, // 适当的顶部间距
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // 关闭 Drawer
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          WorkNavbar(),
          Expanded(
            child: Container(
                color: AppColors.backgroundColor,
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    margin: const EdgeInsets.all(16),
                    child: WorkSelect(),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      child: WorkDepartmentPage(),
                    ),
                  ),
                ])),
          )
        ],
      ),
    );
  }
}
