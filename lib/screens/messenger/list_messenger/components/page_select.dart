import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class PageSelect extends StatefulWidget {
  const PageSelect({Key key}) : super(key: key);

  @override
  _PageSelectState createState() => _PageSelectState();
}

class _PageSelectState extends State<PageSelect> {
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
    showModalBottomSheet(
      context: context,
      builder: (context) => _pageSelect(),
    );
  }

  Widget _pageSelect() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Layouts.SPACING,
              vertical: Layouts.SPACING / 2,
            ),
            child: Text(
              'Trang quản lý',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          _listPage(),
        ],
      ),
    );
  }

  Widget _listPage() {
    final pages = AzsalesData.instance.pages;
    return Flexible(
      child: SingleChildScrollView(
        child: Wrap(
          children: List.generate(pages.length,
              (index) => _itemPage(pages.values.elementAt(index))),
        ),
      ),
    );
  }

  Widget _itemPage(FacebookPage page) {
    return ListTile(
      title: Text(page.name),
      trailing: Icon(
        Icons.check_rounded,
        color: Colors.blue,
      ),
    );
  }
}
