import 'package:cntt2_crm/components/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

//Components
import 'components/body.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Cart.dart';
import 'package:cntt2_crm/models/list_model/ProductList.dart';

class SelectProductScreen extends StatefulWidget {
  const SelectProductScreen({Key key}) : super(key: key);
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  bool _isMutil = false;
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectProductScreenAppBar(context),
      body: MultiProvider(
        providers: [
          Provider.value(
            value: _isMutil,
          ),
          ChangeNotifierProvider<ProductList>.value(
            value: AzsalesData.instance.products,
          ),
        ],
        child: const Body(),
      ),
      bottomNavigationBar: _isMutil ? _selectOptionButton(context) : null,
    );
  }

  Widget _selectProductScreenAppBar(BuildContext context) {
    return AppBar(
      title: _searchBar(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: _toolBar(),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      controller: _search,
      style: Theme.of(context).textTheme.bodyText2,
      autofocus: false,
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).accentColor,
        ),
        hintText: "Tên, Barcode",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onEditingComplete: () {
        if (_search.text.isNotEmpty) {
          FocusScope.of(context).unfocus();
          showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ProgressDialog(
              future: AzsalesData.instance.products.searchProduct(_search.text),
              loading: 'Đang tìm kiếm sản phẩm',
              success: 'Tìm kiếm sản phẩm thành công',
              falied: 'Tìm kiếm sản phẩm thất bại',
            ),
          ).then(
            (value) {
              return value ? _search.text = '' : null;
            },
          );
        }
      },
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
          _filterDropdown(),
          Spacer(),
          _mutilChoice(),
        ],
      ),
    );
  }

  Widget _mutilChoice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Chọn nhiều',
          style: TextStyle(fontSize: Fonts.SIZE_TEXT_MEDIUM),
        ),
        SizedBox(width: Layouts.SPACING / 2),
        FlutterSwitch(
          height: 30,
          width: 50,
          value: _isMutil,
          onToggle: (val) {
            setState(() {
              _isMutil = val;
            });
          },
        )
      ],
    );
  }

  Widget _filterDropdown() {
    final productsList = AzsalesData.instance.products;
    return DropdownButton<int>(
      style: Theme.of(context).textTheme.bodyText2,
      elevation: 0,
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      value: productsList.filterId,
      items: List.generate(
        ProductList.filter.length,
        (index) => DropdownMenuItem(
          value: index,
          child: Text(ProductList.filter[index]),
        ),
      ),
      onChanged: (value) {
        setState(() {
          productsList.filterId = value;
        });
      },
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
