import 'package:flutter/material.dart';
import 'package:work_order/widgets/custom_appbar.dart';
import '../utils/app_colors.dart';
import 'timeline_detail.dart';
import 'work_order_details.dart';

class WorkDetailPage extends StatefulWidget {
  const WorkDetailPage({super.key});

  @override
  _WorkDetailPageState createState() => _WorkDetailPageState();
}

class _WorkDetailPageState extends State<WorkDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3875c6),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50), // 设置 TabBar 的高度
          child: Container(
            color: Colors.white, // 设置 TabBar 的背景颜色
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.blue, // 设置选中标签的指示器颜色
              labelColor: Colors.blue, // 设置选中标签的文本颜色
              unselectedLabelColor: Colors.grey, // 设置未选中标签的文本颜色
              dividerColor: Colors.white,
              tabs: [
                Tab(text: 'Follow-Up Records'),
                Tab(text: 'Work Order Details'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        // 使用 TabBarView 来显示对应的内容
        controller: _tabController,
        children: [
          Container(
            color: AppColors.backgroundColor, // 设置背景颜色为 #F3F3F3
            // 支持滚动
            child: Column(
              children: [
                Expanded(
                  child: TimelineWithDetails(), // 确保此组件的高度适当
                ),
                Container(
                  color: Colors.white.withAlpha(60), // 设置背景颜色为 #EAEBF2
                  height: 72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 16,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/operation_records');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20), // 上下12，左右20
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6), // 圆角6dp
                          ),
                          backgroundColor: Color(0xFFF3F3F3), // 背景颜色
                        ),
                        child: Text(
                          'Operation record',
                          style: TextStyle(
                            color: Colors.black, // 文字颜色
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/create_record');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20), // 上下12，左右20
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6), // 圆角6dp
                          ),
                          backgroundColor: Color(0xFF216BF0), // 背景颜色
                        ),
                        child: Text(
                          'New record',
                          style: TextStyle(
                            color: Colors.white, // 文字颜色
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          WorkOrderDetails(
            workOrderTitle: 'Thermo Fisher Scientific Inc',
            handler: 'John Doe',
            applicableRoles: 'Manager, HR',
            applicableUsers: 'Alice, Bob',
            description:
                'Employee A submits a resignation application, completes work handover, returns company assets, and finalizes exit procedures. After approval from the supervisor, HR issues the resignation certificate.',
            attachments: [
              'Employee_Resignation_Form.pdf',
              'Asset_Return_Checklist.pdf',
              'Exit_Interview_Notes.pdf',
            ],
          ),
        ],
      ),
    );
  }
}
