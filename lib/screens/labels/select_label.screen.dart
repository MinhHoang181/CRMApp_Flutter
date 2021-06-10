import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/testModels.dart';

//Components
import 'components/label_item.dart';

class SelectLabelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectLabelScreenAppBar(context),
      body: _ListLabel(),
    );
  }

  AppBar selectLabelScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Gắn nhãn tin nhắn'),
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
    final _haveLabel = testCustomer.labels.contains(label);
    return ListTile(
      title: LabelItem(label: label),
      trailing: _haveLabel
          ? Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onTap: () {
        setState(() {
          if (_haveLabel) {
            testCustomer.removeLabel(label);
          } else {
            testCustomer.addLabel(label);
          }
        });
      },
    );
  }
}
