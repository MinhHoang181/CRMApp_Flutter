import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation.dart';

//Components
import 'components/label_item.dart';

class SelectLabelScreen extends StatelessWidget {
  const SelectLabelScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectLabelScreenAppBar(context),
      body: _buildList(),
    );
  }

  AppBar selectLabelScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Gắn nhãn tin nhắn'),
    );
  }

  Widget _buildList() {
    final labels = AzsalesData.instance.labels;
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: labels.length,
      itemBuilder: (context, index) => _LabelItemSelect(
        label: labels.values.elementAt(index),
      ),
    );
  }
}

class _LabelItemSelect extends StatefulWidget {
  final Label label;

  const _LabelItemSelect({Key key, @required this.label}) : super(key: key);
  @override
  _LabelItemSelectState createState() => _LabelItemSelectState();
}

class _LabelItemSelectState extends State<_LabelItemSelect> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final conversation = Provider.of<Conversation>(context);
    final haveLabel = conversation.labelIds.contains(widget.label.id);
    return ListTile(
      title: LabelItem(label: widget.label),
      trailing: _iconCheck(haveLabel),
      onTap: _isLoading
          ? null
          : () {
              setState(() {
                _isLoading = true;
                selectLabel(haveLabel, conversation, widget.label.id);
              });
            },
    );
  }

  void selectLabel(
    bool haveLabel,
    Conversation conversation,
    String labelId,
  ) async {
    if (haveLabel) {
      await conversation.unsetLabel(labelId);
    } else {
      await conversation.setLabel(labelId);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Widget _iconCheck(bool haveLabel) {
    if (_isLoading) {
      return CircularProgressIndicator.adaptive();
    }
    return haveLabel
        ? Icon(
            Icons.check,
            color: Theme.of(context).primaryColor,
          )
        : null;
  }
}
