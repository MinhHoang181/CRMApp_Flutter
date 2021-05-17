import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class ChatInputField extends StatefulWidget {
  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
              onPressed: () => {},
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Layouts.SPACING * 0.75,
                vertical: Layouts.SPACING / 3,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(40)),
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Nhập nội dung',
                ),
              ),
            )),
            IconButton(
              icon: Icon(Icons.more_vert_rounded),
              onPressed: () => {},
            )
          ],
        ),
      ),
    );
  }
}
