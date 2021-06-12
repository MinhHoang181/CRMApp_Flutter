import 'package:cntt2_crm/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

//Components
import 'components/body.dart';

class SelectProductScreen extends StatefulWidget {
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  List<String> _dropdownList = [
    'Tất cả sản phẩm',
  ];
  String _filter;
  bool _isMutil = false;

  @override
  void initState() {
    super.initState();
    _filter = _dropdownList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectProductScreenAppBar(context),
      body: Provider.value(
        value: _isMutil,
        child: Body(),
      ),
      bottomNavigationBar: _isMutil ? _selectOptionButton(context) : null,
    );
  }

  Widget _selectProductScreenAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: _searchBar(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: _toolBar(),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 45,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          hintText: "Tên, SKU, Barcode",
        ),
      ),
    );
  }

  Widget _toolBar() {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      padding: const EdgeInsets.symmetric(
        horizontal: Layouts.SPACING,
        vertical: Layouts.SPACING / 2,
      ),
      child: Row(
        children: [
          DropdownButton<String>(
            elevation: 0,
            value: _filter,
            items: _dropdownList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                _filter = newValue;
              });
            },
          ),
          Spacer(),
          Text(
            'Chọn nhiều',
            style: TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM),
          ),
          SizedBox(width: Layouts.SPACING),
          FlutterSwitch(
            height: 30,
            width: 50,
            value: _isMutil,
            onToggle: (val) {
              setState(() {
                _isMutil = val;
                if (!_isMutil)
                  Provider.of<Cart>(context, listen: false).removeAll();
              });
            },
          )
        ],
      ),
    );
  }

  BottomAppBar _selectOptionButton(BuildContext context) {
    return BottomAppBar(
      child: Table(
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(Layouts.SPACING / 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.withOpacity(0.7),
                  ),
                  child: Text('Chọn lại'),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).removeAll();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Layouts.SPACING / 2),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.withOpacity(0.7),
                  ),
                  child: Text(
                    'Xong',
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
