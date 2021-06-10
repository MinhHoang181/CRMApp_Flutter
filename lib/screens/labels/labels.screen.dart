import 'package:cntt2_crm/models/AzsalesData.dart';
import 'package:flutter/material.dart';

//Model
import 'package:cntt2_crm/models/Label.dart';

//Components
import 'components/label_item.dart';

//Screen
import 'label_detail.screen.dart';

class LabelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _labelsScreenAppBar(context),
      body: _ListLabel(),
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

class _ListLabel extends StatefulWidget {
  @override
  _ListLabelState createState() => _ListLabelState();
}

class _ListLabelState extends State<_ListLabel> {
  @override
  Widget build(BuildContext context) {
    final labels = AzsalesData.instance.labels;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: labels.length,
      itemBuilder: (context, index) =>
          _buildRow(labels.values.elementAt(index)),
    );
  }

  Widget _buildRow(Label label) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: LabelItem(label: label),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => {},
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
}
