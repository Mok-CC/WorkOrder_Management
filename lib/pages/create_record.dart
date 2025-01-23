import 'package:flutter/material.dart';
import 'package:work_order/utils/app_colors.dart';
import 'package:work_order/widgets/custom_appbar.dart';
import 'package:work_order/widgets/upload_file.dart';

class CreateRecordPage extends StatefulWidget {
  const CreateRecordPage({super.key});

  @override
  _CreateRecordPageState createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  final _formKey = GlobalKey<FormState>();

  final _uploadedFiles = <String>[];

  final TextEditingController _followUpDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'create record'),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 表单区域
                  _buildForm(),
                  SizedBox(height: 24),
                  // 下载附件区域
                  UploadFile(
                    uploadedFiles: _uploadedFiles,
                    onUpload: () {
                      setState(() {
                        _uploadedFiles
                            .add('file_${_uploadedFiles.length + 1}.pdf');
                      });
                    },
                    onDownload: (file) {
                      print('Downloading $file');
                    },
                    onDelete: (file) {
                      setState(() {
                        _uploadedFiles.remove(file);
                      });
                    },
                  ),
                  SizedBox(height: 56),
                ],
              )),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
              child: Text('Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                Text('Follow-up person',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            DropdownButtonFormField<String>(
              items: [],
              onChanged: null,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '*',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                Text('Follow-up date',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            // 日期选择器
            TextFormField(
              controller: _followUpDateController, // 添加控制器
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectDate, // 添加日期选择器打开逻辑
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
              readOnly: true, // 禁止文本框手动编辑
            ),
            SizedBox(height: 16),
            Text('Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              initialValue: '_description', // 设置默认值
              maxLines: 5,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Enter Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ));
  }

  // 日期选择器逻辑
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _followUpDateController.text = picked.toString().split(' ')[0]; // 格式化日期
      });
    }
  }
}
