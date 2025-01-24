import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkNavbar extends StatelessWidget {
  final bool isDrawerOpen;
  final VoidCallback toggleDrawer;

  const WorkNavbar(
      {required this.isDrawerOpen, required this.toggleDrawer, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 23),
          child: Row(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/icons/gsr.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(width: 8),
              Text('GSR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ))
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
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => {
                  // 打开侧边栏
                  toggleDrawer(),
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
