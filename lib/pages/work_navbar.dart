import 'package:flutter/material.dart';

class WorkNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => {
                  // 打开侧边栏
                  Scaffold.of(context).openDrawer(),
                },
              ),
              Icon(Icons.abc)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                child: Icon(Icons.person),
              ),
              SizedBox(width: 12),
              Text('Robert fox')
            ],
          ),
        )
      ],
    );
  }
}
