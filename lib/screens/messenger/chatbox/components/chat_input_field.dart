import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Screen
import 'package:cntt2_crm/screens/quick_answers/answers.screen.dart';

class ChatInputField extends StatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  var _inputController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Layouts.SPACING / 2,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -1),
                blurRadius: 1,
                color: Theme.of(context).shadowColor,
              ),
            ]),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_bag_rounded),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.chat_rounded),
              onPressed: () =>
                  _navigateToSelectAnswerScreenAndReceiveAnswer(context),
            ),
            Expanded(
              child: TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  hintText: 'Nhập nội dung',
                  suffixIcon: InkWell(
                    child: Icon(Icons.send),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert_rounded),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }

  void _navigateToSelectAnswerScreenAndReceiveAnswer(
      BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnswersScreen(),
      ),
    );
    _inputController.text = result;
  }
}
