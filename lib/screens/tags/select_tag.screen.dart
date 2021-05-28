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
      body: _ListTag(),
    );
  }

  AppBar selectTagScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('Gắn nhãn tin nhắn'),
    );
  }
}

class _ListTag extends StatefulWidget {
  @override
  _ListTagState createState() => _ListTagState();
}

class _ListTagState extends State<_ListTag> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tagsList.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider();
        final i = index ~/ 2;
        return _buildRow(tagsList[i]);
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
