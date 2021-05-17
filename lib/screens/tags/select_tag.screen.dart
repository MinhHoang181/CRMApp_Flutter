import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Tag.dart';
import 'package:cntt2_crm/models/testModels.dart';

//Components
import 'components/tag_item.dart';

class SelectTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectTagScreenAppBar(context),
      body: ListTag(),
    );
  }

  AppBar selectTagScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Gắn nhãn tin nhắn'),
    );
  }
}

class ListTag extends StatefulWidget {
  @override
  _ListTagState createState() => _ListTagState();
}

class _ListTagState extends State<ListTag> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tagsList.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        return _buildRow(tagsList[index]);
      },
    );
  }

  Widget _buildRow(Tag tag) {
    final _haveTag = testCustomer.tags.contains(tag);
    return ListTile(
      title: TagItem(tag: tag),
      trailing: _haveTag
          ? Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            )
          : null,
      onTap: () {
        setState(() {
          if (_haveTag) {
            testCustomer.removeTag(tag);
          } else {
            testCustomer.addTag(tag);
          }
        });
      },
    );
  }
}
