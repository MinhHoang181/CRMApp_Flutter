import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'package:cntt2_crm/screens/components/image_item.dart';

//Models
import 'package:cntt2_crm/models/Shipper.dart';

class ShipperItem extends StatelessWidget {
  const ShipperItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shipper = context.watch<Shipper>();
    return Container(
      margin: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Card(
        elevation: 3,
        child: ExpandablePanel(
          header: _shipper(context, shipper),
          collapsed: null,
          expanded: null,
        ),
      ),
    );
  }

  Widget _shipper(BuildContext context, Shipper shipper) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, shipper.name),
          SizedBox(height: Layouts.SPACING / 2),
          _body(context, shipper),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, String text) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  Widget _body(BuildContext context, Shipper shipper) {
    return Row(
      children: [
        ImageItem(
          url: shipper.urlLogo,
          size: const Size(200, 60),
        ),
        Spacer(),
        _active(context, shipper.isActive),
      ],
    );
  }

  Widget _active(BuildContext context, bool isActive) {
    return isActive
        ? Row(
            children: [
              Icon(Icons.check_box_outlined),
            ],
          )
        : Row(
            children: [
              Icon(Icons.disabled_by_default_outlined),
            ],
          );
  }
}
