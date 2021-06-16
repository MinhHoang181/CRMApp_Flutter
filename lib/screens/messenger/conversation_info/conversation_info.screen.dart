import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'components/list_note/list_note.dart';
import 'components/list_order/list_order.dart';
import 'components/list_customer.dart';
import 'package:cntt2_crm/screens/messenger/conversation_info/components/edit_dialog.dart';
import 'package:cntt2_crm/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Conversation.dart';
import 'package:cntt2_crm/models/list_model/NoteList.dart';
import 'package:cntt2_crm/models/list_model/OrderList.dart';

class ConversationInfoScreen extends StatelessWidget {
  const ConversationInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _conversationInfoAppbar(context),
        body: SafeArea(
          child: TabBarView(
            children: [
              _listNote(context),
              ListCustomer(),
              _listOrder(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _conversationInfoAppbar(BuildContext context) {
    final noteList = Provider.of<Conversation>(context, listen: false).notes;
    return AppBar(
      title: Text('Thông tin hội thoại'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: _tabBar(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.note_add_rounded),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => EditDialog(),
          ).then(
            (value) => value != null
                ? _showCreateProgress(context, noteList, value)
                : null,
          ),
        )
      ],
    );
  }

  Future _showCreateProgress(
      BuildContext context, NoteList noteList, String text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ProgressDialog(
        future: noteList.createNote(text),
        loading: 'Đang tạo ghi chú',
        success: 'Tạo ghi chú thành công',
        falied: 'Tạo ghi chú thất bại',
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

  Widget _listOrder(BuildContext context) {
    final orders = Provider.of<Conversation>(context, listen: false).orders;
    return FutureBuilder<OrderList>(
      future: orders.fetchData(),
      builder: (contex, snapshot) {
        if (snapshot.hasData) {
          return ChangeNotifierProvider<OrderList>.value(
            value: snapshot.data,
            child: ListOrder(),
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
