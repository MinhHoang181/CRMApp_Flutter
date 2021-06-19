import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Label.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Conversation/Conversation.dart';
import 'package:cntt2_crm/models/list_model/LabelList.dart';

//Components
import 'components/label_item.dart';

class SelectLabelScreen extends StatelessWidget {
  const SelectLabelScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectLabelScreenAppBar(context),
      body: FutureBuilder<LabelList>(
        future: AzsalesData.instance.labels.fetchData(),
        builder: (context, snapshop) {
          if (snapshop.hasData) {
            return ChangeNotifierProvider<LabelList>.value(
              value: snapshop.data,
              child: _ListLabel(),
            );
          } else if (snapshop.hasError) {
            print(snapshop.error);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  AppBar selectLabelScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Gắn nhãn tin nhắn'),
    );
  }
}

class _ListLabel extends StatelessWidget {
  const _ListLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labels = Provider.of<LabelList>(context);
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: labels.map.length,
      itemBuilder: (context, index) => ChangeNotifierProvider<Label>.value(
        value: labels.map.values.elementAt(index),
        child: _LabelItemSelect(),
      ),
    );
  }
}

class _LabelItemSelect extends StatefulWidget {
  @override
  _LabelItemSelectState createState() => _LabelItemSelectState();
}

class _LabelItemSelectState extends State<_LabelItemSelect> {
  bool _isLoading = false;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final conversation = Provider.of<Conversation>(context);
    final label = Provider.of<Label>(context);
    final haveLabel = conversation.labelIds.contains(label.id);
    return ListTile(
      title: LabelItem(),
      trailing: _iconCheck(haveLabel),
      onTap: _isLoading
          ? null
          : () {
              setState(() {
                _isLoading = true;
                selectLabel(haveLabel, conversation, label.id);
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
