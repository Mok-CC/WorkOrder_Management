import 'package:flutter/material.dart';
import 'package:work_order/utils/app_colors.dart';

class UploadFile extends StatelessWidget {
  final List<String> uploadedFiles; // 已上传的文件列表（必选）
  final VoidCallback? onUpload; // 文件上传回调（可选）
  final Function(String)? onDownload; // 文件下载回调（可选）
  final Function(String)? onDelete; // 文件删除回调（可选）

  const UploadFile({
    super.key,
    required this.uploadedFiles,
    this.onUpload,
    this.onDownload,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            color: AppColors.backgroundColor,
            child: Column(
              children: [
                if (onUpload != null)
                  GestureDetector(
                    onTap: onUpload,
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.fromLTRB(16, 28, 16, 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload, color: AppColors.primaryColor),
                              SizedBox(width: 8),
                              Text('Click to upload',
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'supporting formats: Word, Excel, PDF, JPG, JPEG, PNG, ZIP, RAR, under 20MB',
                            style: TextStyle(
                                color: AppColors.auxiliaryColor, fontSize: 15),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                if (uploadedFiles.isNotEmpty)
                  Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: uploadedFiles.map((file) {
                        return Container(
                          color: Colors.white,
                          margin: EdgeInsets.all(8), // 为每个 ListTile 添加外边距
                          child: ListTile(
                            leading: Icon(
                              Icons.picture_as_pdf_rounded,
                              color: Colors.deepOrangeAccent,
                            ),
                            title: Text(file),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (onDownload != null)
                                  IconButton(
                                    icon: Icon(Icons.download,
                                        color: Colors.blue),
                                    onPressed: () {
                                      onDownload!(file); // 触发下载回调
                                    },
                                  ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    if (onDelete != null) {
                                      onDelete!(file); // 触发删除回调
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
