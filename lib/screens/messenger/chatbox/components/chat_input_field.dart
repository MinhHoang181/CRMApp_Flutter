import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Screen
import 'package:cntt2_crm/screens/quick_replies/replies.screen.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/screens/product_message/product_message.screen.dart';

//Models
import 'package:cntt2_crm/models/list_model/MessageList.dart';
import 'package:cntt2_crm/models/ChatMessage.dart';
import 'package:cntt2_crm/models/ProductMessage.dart';

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
                onPressed: () => _productMessage(context)),
            IconButton(
              icon: Icon(Icons.chat_rounded),
              onPressed: () => _selectAnswer(context),
            ),
            Expanded(
              child: TextField(
                style: Theme.of(context).textTheme.headline3.copyWith(
                      fontSize:
                          Theme.of(context).textTheme.bodyText2.fontSize + 2,
                    ),
                maxLines: 6,
                minLines: 1,
                controller: _inputController,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Nhập nội dung',
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onEditingComplete: () =>
                    _sendTextMessage(_inputController.text),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _sendTextMessage(_inputController.text),
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

  void _productMessage(BuildContext context) async {
    ProductMessage productMessage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (context) => ProductMessage(),
          child: ProductMessageScreen(),
        ),
      ),
    );
    if (productMessage != null) {
      _sendMultiMessage(
        [
          productMessage.toMessage,
        ],
        productMessage.photos,
      );
    }
  }

  void _sendTextMessage(String text) async {
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
            onPressed: () => _sendTextMessage(text),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _sendImageMessage(String url) async {
    if (url.isNotEmpty) {
      final messageList = Provider.of<MessageList>(context, listen: false);
      final ChatMessage message = new ChatMessage(
        message: '',
        messageType: MessageType.attachment,
        attachments: [
          new Attachment(
            url: url,
            reviewUrl: url,
            attachmentType: AttachmentType.image,
          )
        ],
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
            'Lỗi không gửi được ảnh',
          ),
          action: SnackBarAction(
            label: 'Gửi lại',
            onPressed: () => _sendImageMessage(url),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  _sendMultiMessage(List<String> texts, List<String> urls) async {
    if (texts.isNotEmpty || urls.isNotEmpty) {
      final messageList = Provider.of<MessageList>(context, listen: false);
      List<ChatMessage> messages = List.empty(growable: true);
      if (urls.isNotEmpty) {
        urls.forEach((url) {
          final ChatMessage message = new ChatMessage(
            message: '',
            messageType: MessageType.attachment,
            attachments: [
              new Attachment(
                url: url,
                reviewUrl: url,
                attachmentType: AttachmentType.image,
              )
            ],
            isSender: true,
            isUpdate: false,
          );
          messages.add(message);
        });
      }
      if (texts.isNotEmpty) {
        texts.forEach((text) {
          final ChatMessage message = new ChatMessage(
            message: text,
            messageType: MessageType.text,
            isSender: true,
            isUpdate: false,
          );
          messages.add(message);
        });
      }
      setState(() {
        widget.scrollController.jumpTo(0.0);
        _inputController.clear();
      });
      final result = await Future.wait<bool>(
        List.generate(
          messages.length,
          (index) => messageList.sendMessage(
            messages[index],
          ),
        ),
      );
      List<ChatMessage> failedMessage = List.empty(growable: true);
      for (var i = 0; i < result.length; i++) {
        if (!result[i]) {
          failedMessage.add(messages[i]);
        }
      }
      if (failedMessage.isNotEmpty) {
        texts.clear();
        urls.clear();
        failedMessage.forEach((message) {
          switch (message.messageType) {
            case MessageType.text:
              texts.add(message.message);
              break;
            case MessageType.attachment:
              urls.add(message.attachments[0].url);
              break;
            default:
          }
        });
        final snackBar = SnackBar(
          content: Text(
            'Lỗi không gửi tin nhắn',
          ),
          action: SnackBarAction(
            label: 'Gửi lại',
            onPressed: () => _sendMultiMessage(texts, urls),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
