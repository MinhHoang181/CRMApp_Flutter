import 'package:flutter/material.dart';

//Model
import 'package:cntt2_crm/models/Tag.dart';
import 'package:cntt2_crm/models/testModels.dart';

//Components
import 'components/tag_item.dart';

//Screen
import 'tag_detail.screen.dart';

class TagsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _tagsScreenAppBar(context),
      body: _ListTag(),
    );
  }

  AppBar _tagsScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Quản lý nhãn hội thoại'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TagDetailScreen(),
            ),
          ),
        ),
      ],
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
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TagItem(tag: tag),
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
          builder: (context) => TagDetailScreen(
            tag: tag,
          ),
        ),
      ),
    );
  }
}
