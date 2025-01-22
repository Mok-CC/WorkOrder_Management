import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:work_order/widgets/custom_appbar.dart';

// 操作记录表格页面
class OperationRecordsPage extends StatefulWidget {
  const OperationRecordsPage({super.key});

  @override
  _OperationRecordsPageState createState() => _OperationRecordsPageState();
}

class _OperationRecordsPageState extends State<OperationRecordsPage> {
  // 模拟表格数据
  final List<PlutoColumn> columns = [];
  final List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;

  @override
  void initState() {
    super.initState();

    // 定义列
    columns.addAll([
      PlutoColumn(
        title: 'NO',
        field: 'no',
        type: PlutoColumnType.number(),
        width: 100, // 设置较小的宽度
        enableSorting: false, // 不允许排序
        backgroundColor: Color(0xffF7F8FA), // 背景色
        enableContextMenu: false, // 不允许右键菜单
        enableDropToResize: false, // 不允许拖动调整列宽
        enableEditingMode: false, // 不允许编辑
      ),
      PlutoColumn(
        title: 'RECORDNumber',
        field: 'recordNumber',
        type: PlutoColumnType.text(),
        width: 200, // 设置较大的宽度
        enableSorting: false, // 不允许排序
        backgroundColor: Color(0xffF7F8FA), // 背景色
        enableContextMenu: false, // 不允许右键菜单
        enableDropToResize: false, // 不允许拖动调整列宽
        enableEditingMode: false, // 不允许编辑
      ),
      PlutoColumn(
        title: 'Operator',
        field: 'operator',
        type: PlutoColumnType.text(),
        width: 200, // 设置较大的宽度
        enableSorting: false, // 不允许排序
        backgroundColor: Color(0xffF7F8FA), // 背景色
        enableContextMenu: false, // 不允许右键菜单
        enableDropToResize: false, // 不允许拖动调整列宽
        enableEditingMode: false, // 不允许编辑
      ),
      PlutoColumn(
          title: 'W',
          field: 'w',
          type: PlutoColumnType.text(),
          width: 100, // 设置较小的宽度
          enableSorting: false, // 不允许排序
          backgroundColor: Color(0xffF7F8FA), // 背景色
          enableContextMenu: false, // 不允许右键菜单
          enableDropToResize: false, // 不允许拖动调整列宽
          enableEditingMode: false, // 不允许编辑
          renderer: (rendererContext) {
            final value = rendererContext.cell.value;
            return Text(
              value == null || value.toString().isEmpty
                  ? '-'
                  : value.toString(),
              style: TextStyle(color: Colors.black, fontSize: 16),
            );
          }),
    ]);

    // 定义行数据
    rows.addAll([
      PlutoRow(
        cells: {
          'no': PlutoCell(value: 1),
          'recordNumber': PlutoCell(value: '123456'),
          'operator': PlutoCell(value: 'John Doe'),
          'w': PlutoCell(value: ''),
        },
      ),
      PlutoRow(
        cells: {
          'no': PlutoCell(value: 2),
          'recordNumber': PlutoCell(value: '789012'),
          'operator': PlutoCell(value: 'Jane Smith'),
          'w': PlutoCell(value: 'N'),
        },
      ),
      PlutoRow(
        cells: {
          'no': PlutoCell(value: 3),
          'recordNumber': PlutoCell(value: '345678'),
          'operator': PlutoCell(value: 'Alice Johnson'),
          'w': PlutoCell(value: 'Y'),
        },
      ),
      PlutoRow(
        cells: {
          'no': PlutoCell(value: 4),
          'recordNumber': PlutoCell(value: '901234'),
          'operator': PlutoCell(value: 'Bob Brown'),
          'w': PlutoCell(value: 'N'),
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final title = args?['title'] ?? 'Operation Records';

    return Scaffold(
        appBar: CustomAppBar(title: title),
        body: Container(
          padding: EdgeInsets.all(15),
          child: PlutoGrid(
            columns: columns,
            rows: rows,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              stateManager = event.stateManager;
            },
            onChanged: (PlutoGridOnChangedEvent event) {
              print(event.row.cells[event.column.field]?.value);
            },
            configuration: PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
                enableCellBorderVertical: false, // 禁用单元格边框
                gridBorderColor: Colors.white,
              ), // 网格线颜色,
              columnSize: PlutoGridColumnSizeConfig(
                autoSizeMode: PlutoAutoSizeMode.scale, // 自动调整列宽
              ),
            ),
          ),
        ));
  }
}
