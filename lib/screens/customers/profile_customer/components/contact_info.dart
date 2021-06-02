import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';
import 'package:provider/provider.dart';

class ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customer>(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(Layouts.SPACING),
      child: Row(
        children: [
          CircleAvatarWithPlatform(
            radius: 30,
          ),
          SizedBox(width: Layouts.SPACING),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.SIZE_TEXT_MEDIUM,
                ),
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Row(
                children: [
                  Icon(Icons.phone_rounded,
                      color: customer.phone != null
                          ? Colors.blue
                          : Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5)),
                  SizedBox(width: Layouts.SPACING / 2),
                  Text(
                    customer.phone != null ? customer.phone : '---',
                    style: TextStyle(
                      color: customer.phone != null
                          ? Colors.blue
                          : Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Row(
                children: [
                  Icon(
                    Icons.email_rounded,
                    color: customer.email != null
                        ? Colors.blue
                        : Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.5),
                  ),
                  SizedBox(width: Layouts.SPACING / 2),
                  Text(
                    customer.email != null ? customer.email : '---',
                    style: TextStyle(
                      color: customer.email != null
                          ? Colors.blue
                          : Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
