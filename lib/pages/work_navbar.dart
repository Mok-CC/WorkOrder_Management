import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkNavbar extends StatelessWidget {
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
                  width: 48,
                  height: 48,
                ),
              ),
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
                  Scaffold.of(context).openDrawer(),
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
