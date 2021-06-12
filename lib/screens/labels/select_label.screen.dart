import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation.dart';

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
    final labels = AzsalesData.instance.labels;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: labels.length,
      itemBuilder: (context, index) =>
          _buildRow(labels.values.elementAt(index)),
    );
  }

  Widget _buildRow(Label label) {
    final _haveLabel =
        Provider.of<Conversation>(context).labelIds.contains(label.id);
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
            //testCustomer.removeLabel(label);
          } else {
            //testCustomer.addLabel(label);
          }
        });
      },
    );
  }
}
