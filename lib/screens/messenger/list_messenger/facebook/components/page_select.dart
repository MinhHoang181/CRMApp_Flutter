import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Facebook/FacebookPage.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

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
          children: List.generate(
            pages.map.length,
            (index) => PageItemSelect(
              page: pages.map.values.elementAt(index),
            ),
          ),
        ),
      ),
    );
  }
}

class PageItemSelect extends StatefulWidget {
  final FacebookPage page;
  const PageItemSelect({Key key, @required this.page}) : super(key: key);

  @override
  _PageItemSelectState createState() => _PageItemSelectState();
}

class _PageItemSelectState extends State<PageItemSelect> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.page.name),
      trailing: widget.page.isSelected
          ? Icon(
              Icons.check_rounded,
              color: Colors.blue,
            )
          : null,
      onTap: () {
        setState(() {
          widget.page.toggleSelect();
        });
      },
    );
  }
}
