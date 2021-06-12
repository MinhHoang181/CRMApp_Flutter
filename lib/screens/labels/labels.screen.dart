import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:future_button/future_button.dart';
import 'package:provider/provider.dart';

//Model
import 'package:cntt2_crm/models/Label.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Components
import 'components/label_item.dart';

//Screen
import 'label_detail.screen.dart';

class LabelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _labelsScreenAppBar(context),
      body: _listLabel(context),
    );
  }

  AppBar _labelsScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý nhãn hội thoại'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LabelDetailScreen(),
            ),
          ),
        ),
      ],
    );
  }

  final RefreshController _refreshController = RefreshController();

  void _onRefresh() async {
    await AzsalesData.instance.refreshLabels();
    _refreshController.refreshCompleted();
  }

  Widget _listLabel(BuildContext context) {
    final labels = Provider.of<AzsalesData>(context).labels;
    return SmartRefresher(
      header: ClassicHeader(
        idleText: 'Kéo xuống để làm mới danh sách nhãn',
        releaseText: 'Thả ra để làm mới danh sách nhãn',
        refreshingText: 'Đang làm mới danh sách nhãn',
        completeText: 'Đã làm mới danh sách nhãn',
        failedText: 'Làm mới danh sách nhãn thất bại',
      ),
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: labels.length,
        itemBuilder: (context, index) =>
            _buildRow(context, labels.values.elementAt(index)),
      ),
    );
  }

  Widget _buildRow(BuildContext context, Label label) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: LabelItem(label: label),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _deleteDialog(context, label.id),
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LabelDetailScreen(
            label: label,
          ),
        ),
      ),
    );
  }

  Widget _deleteDialog(BuildContext context, String labelId) {
    return AlertDialog(
      content: Text('Xác nhận xoá nhãn?'),
      actions: [
        TextButton(
          child: Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FutureCupertinoButton(
          child: Text(
            'Xoá',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          onPressed: () async {
            await AzsalesData.instance.removeLabel(labelId);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
