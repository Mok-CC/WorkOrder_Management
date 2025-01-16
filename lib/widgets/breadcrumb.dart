// 面包屑路由导航组件
import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  final List<String> paths;
  const Breadcrumb({super.key, required this.paths});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: paths.map((path) {
        int index = paths.indexOf(path);
        return Row(
          children: [
            Text(
              path,
              style: TextStyle(
                  color: index > 0 ? Colors.black : Colors.grey, fontSize: 12),
            ),
            if (index < paths.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('/',
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              )
          ],
        );
      }).toList(),
    );
  }
}
