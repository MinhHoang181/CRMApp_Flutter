import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'components/list_note/list_note.dart';
import 'components/list_order.dart';
import 'components/list_customer.dart';

//Models
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/list_model/NoteList.dart';

class ConversationInfoScreen extends StatelessWidget {
  const ConversationInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _conversationInfoAppbar(context),
        body: TabBarView(
          children: [
            _listNote(context),
            ListCustomer(),
            ListOrder(),
          ],
        ),
      ),
    );
  }

  AppBar _conversationInfoAppbar(BuildContext context) {
    return AppBar(
      title: Text('Thông tin hội thoại'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _tabBar(context),
      ),
    );
  }

  Widget _tabBar(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBar(
        labelColor: Theme.of(context).textTheme.bodyText1.color,
        tabs: [
          Tab(
            text: ' Ghi chú',
          ),
          Tab(
            text: 'Khách hàng',
          ),
          Tab(
            text: 'Đơn hàng',
          )
        ],
      ),
    );
  }

  Widget _listNote(BuildContext context) {
    final notes = Provider.of<Conversation>(context, listen: false).notes;
    return FutureBuilder<NoteList>(
      future: notes.fetchData(),
      builder: (contex, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<NoteList>.value(
            value: snapshot.data,
            child: ListNode(),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
