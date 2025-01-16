import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  final String title;
  final String? creationTime;
  final String? workOrderNumber;
  final String? handler;
  final bool isFolder;
  final void Function() onEdit;
  final void Function() onDelete;

  const BottomSheetWidget({
    super.key,
    required this.title,
    this.creationTime,
    this.workOrderNumber,
    this.handler,
    required this.isFolder,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  bool _isStatus = true;

  // 删除或关闭的对话框
  void _showAlertDialog(String title, String content, Function onConfirm) {
    AlertDialog alert = AlertDialog(
      title: Text(
        'Confirm delete 【$title】',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Color(0xFFF7F8FA)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onPressed: () {
                  // 关闭对话框
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xFFF7F8FA),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 24, left: 16, bottom: 24), // 确保标题距离上面24dp
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Creation Time', widget.creationTime),
                    widget.isFolder
                        ? Container()
                        : _buildInfoRow(
                            'Work Order Number', widget.workOrderNumber),
                    widget.isFolder
                        ? Container()
                        : _buildInfoRow('Handler', widget.handler),
                    widget.isFolder
                        ? Container()
                        : _buildSwitchInfoRow('Status'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                color: Colors.white,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showAlertDialog(
                              'folder name',
                              'Once deleted, all data within this folder will be cleared and cannot be recovered. please proceed with caution',
                              () {});
                        },
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ]),
              )
            ],
          ),
        ));
  }

  Widget _buildInfoRow(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(height: 6),
        Text(
          value ?? '',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }

  Widget _buildSwitchInfoRow(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          Switch(
            value: _isStatus, // 这里可以改为实际的状态值
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            onChanged: (value) {
              // 状态改变的逻辑
              setState(() {
                _isStatus = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
