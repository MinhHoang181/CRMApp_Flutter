import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Models
import 'package:cntt2_crm/models/Cart.dart';

//Components
import 'package:cntt2_crm/screens/components/progress_dialog.dart';

class ReceiveOrderButton extends StatefulWidget {
  const ReceiveOrderButton({Key key}) : super(key: key);

  @override
  _ReceiveOrderButtonState createState() => _ReceiveOrderButtonState();
}

class _ReceiveOrderButtonState extends State<ReceiveOrderButton> {
  Widget _button;
  @override
  void initState() {
    super.initState();
    _button = _receiveButton();
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

  Widget _receiveButton() {
    return ElevatedButton(
      child: Text('Đã nhận hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
        showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ProgressDialog(
            future: cart.receiveOrder(),
            loading: 'Đang cập nhật đơn hàng',
            success: 'Cập nhật đơn hàng thành công',
            falied: 'Cập nhật đơn hàng thất bại',
          ),
        ).then((value) {
          if (value != null) {
            if (value) {
              Navigator.of(context).pop();
            }
          }
        });
      },
    );
  }

  Widget _returningButton() {
    return ElevatedButton(
      child: Text('Trả hàng'),
      onPressed: () {
        final cart = Provider.of<Cart>(context, listen: false);
        showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ProgressDialog(
            future: cart.returningOrder(),
            loading: 'Đang cập nhật đơn hàng',
            success: 'Cập nhật đơn hàng thành công',
            falied: 'Cập nhật đơn hàng thất bại',
          ),
        ).then((value) {
          if (value != null) {
            if (value) {
              Navigator.of(context).pop();
            }
          }
        });
      },
    );
  }

  Widget _actionButton() {
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
            if (value == 1) _button = _receiveButton();
            if (value == 2) _button = _returningButton();
            setState(() {});
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
                  Icon(Icons.money_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Đã nhận hàng',
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
                  Icon(Icons.replay_circle_filled_rounded),
                  SizedBox(
                    width: Layouts.SPACING,
                  ),
                  Text(
                    'Trả hàng',
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
        ],
      ),
    );
  }
}
