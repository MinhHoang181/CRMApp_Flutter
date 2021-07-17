import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Cart.dart';

//Components
import 'components/confirm_button.dart';
import 'components/edit_button.dart';
import 'components/cancel_button.dart';

class NewOrderActions extends StatefulWidget {
  const NewOrderActions({Key key}) : super(key: key);

  @override
  _NewOrderActionsState createState() => _NewOrderActionsState();
}

class _NewOrderActionsState extends State<NewOrderActions> {
  Widget _button;
  @override
  void initState() {
    super.initState();
    _button = ConfirmButton();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _button,
        ),
        SizedBox(
          width: Layouts.SPACING,
        ),
        _actionButton(),
      ],
    );
  }

  Widget _actionButton() {
    final cart = Provider.of<Cart>(context, listen: false);
    bool canEdit = false;
    return IconButton(
      icon: Icon(Icons.more_vert_rounded),
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (_) => _listAction(),
        ).then((value) {
          if (value != null) {
            if (value == 1) _button = ConfirmButton();
            if (value == 2) {
              _button = EditButton();
              canEdit = true;
            }
            if (value == 3) _button = CancelButton();
            setState(() {
              cart.canEdit = canEdit;
            });
          }
        });
      },
    );
  }

  Widget _listAction() {
    return Container(
      padding: const EdgeInsets.only(
        top: Layouts.SPACING / 2,
        bottom: Layouts.SPACING * 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING),
              child: Row(
                children: [
                  Icon(Icons.check_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Duyệt đơn hàng',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize +
                                  2,
                        ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).pop(1),
          ),
          Divider(),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING),
              child: Row(
                children: [
                  Icon(Icons.edit_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Sửa đơn hàng',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize +
                                  2,
                        ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).pop(2),
          ),
          Divider(),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(Layouts.SPACING),
              child: Row(
                children: [
                  Icon(Icons.delete_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Hủy đơn hàng',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize +
                                  2,
                        ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context).pop(3),
          ),
          Divider(),
        ],
      ),
    );
  }
}
