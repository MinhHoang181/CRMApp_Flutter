import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/QuickAnswer.dart';
import 'package:cntt2_crm/models/testModels.dart';

class SelectAnswerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectAnswerScreenAppBar(context),
      body: _ListAnswer(),
    );
  }

  AppBar _selectAnswerScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Chọn câu trả lời mẫu'),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => {},
        ),
      ],
    );
  }
}

class _ListAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: answerList.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => _buildRow(context, answerList[index]),
    );
  }

  Widget _buildRow(BuildContext context, QuickAnswer answer) {
    return ListTile(
      title: Text(answer.shortcut),
      onTap: () => Navigator.pop(context, answer.text),
    );
  }
}
