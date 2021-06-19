import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Screen
import 'package:cntt2_crm/screens/quick_replies/replies.screen.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/list_model/MessageList.dart';

class ChatInputField extends StatefulWidget {
  final ScrollController scrollController;

  const ChatInputField({Key key, @required this.scrollController})
      : super(key: key);
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
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_bag_rounded),
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.chat_rounded),
              onPressed: () => _selectAnswer(context),
            ),
            Expanded(
              child: TextField(
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 6,
                minLines: 1,
                controller: _inputController,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Nhập nội dung',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onEditingComplete: () => _sendMessage(_inputController.text),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _sendMessage(_inputController.text),
            ),
          ],
        ),
      ),
    );
  }

  void _selectAnswer(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RepliesScreen(),
      ),
    );
    _inputController.text = result;
  }

  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      final messageList = Provider.of<MessageList>(context, listen: false);
      final ChatMessage message = new ChatMessage(
        message: text,
        messageType: MessageType.text,
        isSender: true,
        isUpdate: false,
      );
      setState(() {
        widget.scrollController.jumpTo(0.0);
        _inputController.clear();
      });
      final success = await messageList.sendMessage(message);
      if (!success) {
        final snackBar = SnackBar(
          content: Text(
            'Lỗi không gửi được tin nhắn',
          ),
          action: SnackBarAction(
            label: 'Gửi lại',
            onPressed: () => _sendMessage(text),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
