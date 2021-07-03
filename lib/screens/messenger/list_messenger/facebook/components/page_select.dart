import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';

//Components
import 'package:cntt2_crm/components/progress_dialog.dart';

class PageSelect extends StatelessWidget {
  const PageSelect({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          Icons.pages_rounded,
          color: Colors.white,
        ),
        onPressed: () => _showPageSelect(context),
      ),
    );
  }

  void _showPageSelect(BuildContext context) {
    final conversations = Provider.of<Conversations>(context, listen: false);
    showDialog<List<String>>(
      context: context,
      builder: (_) => _pageSelect(context),
    ).then((value) {
      if (value != null) {
        AzsalesData.instance.pages.toggleAllPage(value);
        showDialog(
          context: context,
          builder: (_) => ProgressDialog(
            future: conversations.refreshAll(),
            loading: 'Đang cập nhật lại danh sách tin nhắn',
            success: 'Cập nhật danh sách tin nhắn thành công',
            falied: 'Cập nhật tin nhắn thất bại',
          ),
        );
      }
    });
  }

  Widget _pageSelect(BuildContext context) {
    final List<String> selectList =
        AzsalesData.instance.pages.selectedPageIds.toList();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Layouts.SPACING,
              vertical: Layouts.SPACING / 2,
            ),
            child: Text('Trang quản lý',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          ListPageSelect(selectList: selectList),
          _button(context, selectList),
        ],
      ),
    );
  }

  Widget _button(BuildContext context, List<String> selectList) {
    return Table(
      children: [
        TableRow(
          children: [
            TextButton(
              child: Text('Thoát'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Lưu'),
              onPressed: () {
                Navigator.of(context).pop(selectList);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ListPageSelect extends StatefulWidget {
  final List<String> selectList;
  const ListPageSelect({Key key, @required this.selectList}) : super(key: key);

  @override
  _ListPageSelectState createState() => _ListPageSelectState();
}

class _ListPageSelectState extends State<ListPageSelect> {
  bool _isAllPage;

  @override
  Widget build(BuildContext context) {
    final pages = AzsalesData.instance.pages;
    _isAllPage = pages.isAllSelected(selectList: widget.selectList);
    return ListView(
      shrinkWrap: true,
      children: [
        _allPageItemSelect(context),
      ]..addAll(
          List.generate(
            pages.map.length,
            (index) => _pageItemSelect(
              context,
              pages.map.values.elementAt(index),
            ),
          ),
        ),
    );
  }

  Widget _allPageItemSelect(BuildContext context) {
    return ListTile(
      title: Text(
        'Tất cả các trang',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: _isAllPage
          ? Icon(
              Icons.check_rounded,
              color: Colors.blue,
            )
          : null,
      onTap: () {
        setState(() {
          if (_isAllPage) {
            widget.selectList.clear();
          } else {
            widget.selectList.clear();
            widget.selectList.addAll(AzsalesData.instance.pages.pageIds);
          }
        });
      },
    );
  }

  Widget _pageItemSelect(BuildContext context, FacebookPage page) {
    bool _isSelect = widget.selectList.contains(page.id);
    return ListTile(
      title: Text(
        page.name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: _isSelect
          ? Icon(
              Icons.check_rounded,
              color: Colors.blue,
            )
          : null,
      onTap: () {
        setState(() {
          if (_isSelect) {
            widget.selectList.remove(page.id);
          } else {
            widget.selectList.add(page.id);
          }
        });
      },
    );
  }
}
