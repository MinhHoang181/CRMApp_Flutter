import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'components/tag_detail.dart';

class AddTagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addTagScreenAppBar(context),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(Layouts.SPACING),
          child: Stack(
            children: [
              TagDetail(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: _saveButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _addTagScreenAppBar(BuildContext context) {
    return AppBar(
      title: Text('Thêm nhãn hội thoại'),
    );
  }

  ElevatedButton _saveButton() {
    return ElevatedButton(
      onPressed: () => {},
      child: Text('Lưu'),
    );
  }
}
