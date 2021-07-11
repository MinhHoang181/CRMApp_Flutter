import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/icons.dart' as MyIcons;

//Models
import 'package:cntt2_crm/models/ProductMessage.dart';

//Screens
import '../select_product/select_prouct.screen.dart';

class Options extends StatelessWidget {
  const Options({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _selectProduct(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HasPhotoCheckBox(),
              SizedBox(width: Layouts.SPACING / 2),
              HasPriceCheckbox(),
              SizedBox(width: Layouts.SPACING / 2),
              HasAttribute(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _selectProduct(BuildContext context) {
    final productMessage = context.watch<ProductMessage>();
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Layouts.SPACING * 2,
        vertical: Layouts.SPACING,
      ),
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.5),
            Theme.of(context).primaryColor.withOpacity(1),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Theme.of(context).primaryColorLight,
          ),
        ],
      ),
      child: InkWell(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: Image(
                  image: AssetImage(MyIcons.CHOOSE_PRODUCT),
                ),
              ),
              SizedBox(height: Layouts.SPACING / 3),
              Text(
                'Chọn sản phẩm',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<ProductMessage>.value(
              value: productMessage,
              child: SelectProductScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class HasPhotoCheckBox extends StatefulWidget {
  const HasPhotoCheckBox({Key key}) : super(key: key);

  @override
  _HasPhotoCheckBoxState createState() => _HasPhotoCheckBoxState();
}

class _HasPhotoCheckBoxState extends State<HasPhotoCheckBox> {
  bool _isChecked;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _isChecked = Provider.of<ProductMessage>(context, listen: false).hasPhoto;
  }

  @override
  Widget build(BuildContext context) {
    final productMessage = Provider.of<ProductMessage>(context, listen: false);
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value;
              productMessage.hasPhoto = value;
            });
          },
        ),
        Text('Ảnh'),
      ],
    );
  }
}

class HasPriceCheckbox extends StatefulWidget {
  const HasPriceCheckbox({Key key}) : super(key: key);

  @override
  _HasPriceCheckboxState createState() => _HasPriceCheckboxState();
}

class _HasPriceCheckboxState extends State<HasPriceCheckbox> {
  bool _isChecked;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _isChecked = Provider.of<ProductMessage>(context, listen: false).hasPrice;
  }

  @override
  Widget build(BuildContext context) {
    final productMessage = Provider.of<ProductMessage>(context, listen: false);
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value;
              productMessage.hasPrice = value;
            });
          },
        ),
        Text('Giá bán'),
      ],
    );
  }
}

class HasAttribute extends StatefulWidget {
  const HasAttribute({Key key}) : super(key: key);

  @override
  _HasAttributeState createState() => _HasAttributeState();
}

class _HasAttributeState extends State<HasAttribute> {
  bool _isChecked;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _isChecked =
        Provider.of<ProductMessage>(context, listen: false).hasAttribute;
  }

  @override
  Widget build(BuildContext context) {
    final productMessage = Provider.of<ProductMessage>(context, listen: false);
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value;
              productMessage.hasAttribute = value;
            });
          },
        ),
        Text('Thuộc tính'),
      ],
    );
  }
}
