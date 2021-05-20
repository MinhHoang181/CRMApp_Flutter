import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/answer_item.dart';

//Models
import 'package:cntt2_crm/models/QuickAnswer.dart';
import 'package:cntt2_crm/models/testModels.dart';

//Screens
import 'answer_detail.screen.dart';

class AnswersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _answersScreenAppBar(context),
      body: Container(
        margin: EdgeInsets.only(top: Layouts.SPACING),
        child: _ListAnswer(),
      ),
    );
  }

  AppBar _answersScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Tin trả lời lưu sẵn'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnswerDetailScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ListAnswer extends StatefulWidget {
  @override
  __ListAnswerState createState() => __ListAnswerState();
}

class __ListAnswerState extends State<_ListAnswer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: answerList.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) return Divider();
        final i = index ~/ 2;
        return _buildRow(context, answerList[i]);
      },
    );
  }

  Widget _buildRow(BuildContext context, QuickAnswer answer) {
    return AnswerItem(
      answer: answer,
    );
  }
}
