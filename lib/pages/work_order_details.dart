import 'package:flutter/material.dart';
import 'package:work_order/widgets/upload_file.dart';
import '../utils/app_colors.dart';

class WorkOrderDetails extends StatefulWidget {
  final String workOrderTitle;
  final String handler;
  final String applicableRoles;
  final String applicableUsers;
  final String description;
  final List<String> attachments;

  const WorkOrderDetails({
    super.key,
    required this.workOrderTitle,
    required this.handler,
    required this.applicableRoles,
    required this.applicableUsers,
    required this.description,
    required this.attachments,
  });

  @override
  _WorkOrderDetailsState createState() => _WorkOrderDetailsState();
}

class _WorkOrderDetailsState extends State<WorkOrderDetails> {
  final List<String> _uploadedFiles = [
    'file_1.pdf',
    'file_2.pdf',
    'file_3.pdf'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        // 添加内边距
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 使用封装的 LabelWithContent 组件
                    LabelWithContent(
                      label: 'Work order title:',
                      content: widget.workOrderTitle,
                      showTooltip: true,
                      tooltipMessage: 'This is the title of the work order.',
                    ),
                    LabelWithContent(
                      label: 'Handler:',
                      content: widget.handler,
                    ),
                    LabelWithContent(
                      label: 'Applicable roles:',
                      content: widget.applicableRoles,
                    ),
                    LabelWithContent(
                      label: 'Applicable users:',
                      content: widget.applicableUsers,
                    ),
                    LabelWithContent(
                      label: 'Description:',
                      content: widget.description,
                    ),
                    // TextField(
                    //   maxLines: 6,
                    //   readOnly: true,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   controller: TextEditingController(
                    //       text:
                    //           'Employee A submits a resignation application, completes work handover, returns company assets, and finalizes exit procedures. After approval from the supervisor, HR issues the resignation certificate.'),
                    // ),
                  ],
                ),
              ),

              SizedBox(height: 20), // 添加间距
              // 展示 Attachments
              UploadFile(
                uploadedFiles: _uploadedFiles,
                onDownload: (file) {
                  print('Downloading $file');
                },
              ),
            ],
          ),
        ));
  }
}

class LabelWithContent extends StatelessWidget {
  final String label;
  final String content;
  final bool showTooltip;
  final String? tooltipMessage;

  const LabelWithContent({
    super.key,
    required this.label,
    required this.content,
    this.showTooltip = false,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12,
          children: [
            Text(
              label,
              style: TextStyle(color: Color(0xFF95969A)),
            ),
            if (showTooltip && tooltipMessage != null)
              Padding(
                padding: const EdgeInsets.all(0),
                child: Tooltip(
                  message: tooltipMessage!,
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Color(0xFF95969A),
                  ),
                ),
              ),
          ],
        ),
        Text(content),
        SizedBox(height: 24), // 添加间距
      ],
    );
  }
}
