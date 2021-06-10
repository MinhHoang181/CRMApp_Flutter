import 'package:flutter/material.dart';

//Model
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/testModels.dart';

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
    return ListView.builder(
      itemCount: labelsList.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider();
        final i = index ~/ 2;
        return _buildRow(labelsList[i]);
      },
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
