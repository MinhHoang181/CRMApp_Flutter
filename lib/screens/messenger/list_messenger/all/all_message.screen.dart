import 'package:cntt2_crm/components/progress_dialog.dart';
import 'package:cntt2_crm/models/Conversation/Conversations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import '../components/body.dart';

//Models
import 'package:cntt2_crm/models/Conversation/FilterConversation.dart';

class AllMessageScreen extends StatefulWidget {
  const AllMessageScreen({Key key}) : super(key: key);

  @override
  _AllMessageScreenState createState() => _AllMessageScreenState();
}

class _AllMessageScreenState extends State<AllMessageScreen> {
  bool _isSearch = false;
  int _indexTab = 0;
  TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filters = Provider.of<Conversations>(context, listen: false).filters;
    return DefaultTabController(
      length: filters.map.length,
      initialIndex: _indexTab,
      child: Scaffold(
        appBar: _facebookMessengerScreenAppBar(),
        body: SafeArea(
          child: TabBarView(
            children: List.generate(
              filters.map.length,
              (index) => _tabBarBody(
                filters.map.values.elementAt(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBarBody(FilterConversation filterConversation) {
    return Provider.value(
      value: filterConversation,
      child: const Body(),
    );
  }

  AppBar _facebookMessengerScreenAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text('Tin nhắn'),
      actions: [
        IconButton(
          icon: _isSearch
              ? Icon(Icons.cancel_outlined)
              : Icon(Icons.search_rounded),
          onPressed: () {
            setState(() {
              _isSearch = !_isSearch;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert_rounded),
          onPressed: () => {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: _isSearch ? Size.fromHeight(90) : Size.fromHeight(40),
        child: _toolBar(),
      ),
    );
  }

  Widget _toolBar() {
    return Column(
      children: [
        if (_isSearch) _searchBar(),
        _tabBar(),
      ],
    );
  }

  Widget _tabBar() {
    final filters = Provider.of<Conversations>(context, listen: false).filters;
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            tabs: List.generate(
              filters.map.length,
              (index) => Tab(
                text: filters.map.keys.elementAt(index),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchBar() {
    final conversations = Provider.of<Conversations>(context, listen: false);
    final filters = Provider.of<Conversations>(context, listen: false).filters;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Layouts.SPACING),
      child: TextField(
        controller: _search,
        style: Theme.of(context).textTheme.bodyText2,
        autofocus: false,
        autocorrect: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          hintText: "Nhập tên, nội dung",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onEditingComplete: () {
          if (_search.text.isNotEmpty) {
            FocusScope.of(context).unfocus();
            showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => ProgressDialog(
                future: conversations.searchData(
                    filters.map.values.elementAt(_indexTab), _search.text),
                loading: 'Đang tìm kiếm tin nhắn',
                success: 'Tìm kiếm tin nhắn thành công',
                falied: 'Tìm kiếm tin nhắn thất bại',
              ),
            ).then(
              (value) {
                return value ? _search.text = '' : null;
              },
            );
          }
        },
      ),
    );
  }
}
