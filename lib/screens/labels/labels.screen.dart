import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Model
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';
import 'package:cntt2_crm/models/Label.dart';

//Components
import 'components/label_item.dart';
import 'package:cntt2_crm/components/progress_dialog.dart';

//Screen
import 'label_detail.screen.dart';

class LabelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _labelsScreenAppBar(context),
      body: FutureBuilder(
        future: Provider.of<LabelList>(context).fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider<LabelList>.value(
              value: snapshot.data,
              child: _ListLabel(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
}

class _ListLabel extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<LabelList>(context).list;
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
        itemBuilder: (context, index) => _buildRow(context, labels[index]),
      ),
    );
  }

  void _onRefresh() async {
    await AzsalesData.instance.labels.refreshLabels();
    _refreshController.refreshCompleted();
  }

  Widget _buildRow(BuildContext context, Label label) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ChangeNotifierProvider<Label>.value(
              value: label,
              child: LabelItem(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog<bool>(
              context: context,
              builder: (context) => _deleteDialog(context),
              barrierDismissible: false,
            ).then(
              (value) => value ? _showDeleteProgress(context, label.id) : null,
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

  Widget _deleteDialog(BuildContext context) {
    return AlertDialog(
      content: Text('Xác nhận xoá nhãn?'),
      actions: [
        TextButton(
          child: Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(
            'Xoá',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }

  Future _showDeleteProgress(BuildContext context, String labelId) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ProgressDialog(
        future: AzsalesData.instance.labels.removeLabel(labelId),
        loading: 'Đang xoá nhãn',
        success: 'Xoá nhãn thành công',
        falied: 'Xoá nhãn thất bại',
      ),
    );
  }
}
