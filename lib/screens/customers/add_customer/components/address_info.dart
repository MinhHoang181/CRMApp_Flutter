import 'package:flutter/material.dart';
import 'package:dvhcvn/dvhcvn.dart' as Location;
import 'package:select_dialog/select_dialog.dart';

class AddressInfo extends StatefulWidget {
  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  Location.Level1 _province;
  String _provinceTitle;
  Location.Level2 _disctrict;
  String _disctrictTitle;
  Location.Level3 _ward;
  String _wardTitle;
  String _address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectProvince(),
        Divider(),
        _selectDisctrict(),
        Divider(),
        _selectWard(),
        Divider(),
        _addressField(),
      ],
    );
  }

  void _showProvinceDialog() {
    SelectDialog.showModal(
      context,
      showSearchBox: false,
      label: 'Chọn tỉnh / thành phố',
      selectedValue: _provinceTitle,
      items: List.generate(
        Location.level1s.length,
        (index) => Location.level1s[index].name,
      ),
      onChange: (selected) {
        setState(() {
          _provinceTitle = selected;
          _province = Location.findLevel1ByName(selected);
          _disctrict = null;
          _disctrictTitle = null;
          _ward = null;
          _wardTitle = null;
        });
      },
    );
  }

  void _showDisctrictDialog() {
    SelectDialog.showModal(
      context,
      showSearchBox: false,
      label: 'Chọn Quận / huyện',
      selectedValue: _provinceTitle,
      items: List.generate(
        _province.children.length,
        (index) => _province.children[index].name,
      ),
      onChange: (selected) {
        setState(() {
          _disctrictTitle = selected;
          _disctrict = _province.findLevel2ByName(selected);
          _ward = null;
          _wardTitle = null;
        });
      },
    );
  }

  void _showWardDialog() {
    SelectDialog.showModal(
      context,
      showSearchBox: false,
      label: 'Chọn Phường / xã',
      selectedValue: _provinceTitle,
      items: List.generate(
        _disctrict.children.length,
        (index) => _disctrict.children[index].name,
      ),
      onChange: (selected) {
        setState(() {
          _wardTitle = selected;
          _ward = _disctrict.findLevel3ByName(selected);
        });
      },
    );
  }

  Widget _selectProvince() {
    return TextField(
      controller: TextEditingController(text: _provinceTitle),
      decoration: InputDecoration(
        hintText: 'Tỉnh / thành phố',
        labelText: 'Tỉnh / thành phố',
        filled: false,
      ),
      readOnly: true,
      onTap: _showProvinceDialog,
    );
  }

  Widget _selectDisctrict() {
    return TextField(
      controller: TextEditingController(text: _disctrictTitle),
      decoration: InputDecoration(
        hintText: 'Quận / huyện',
        labelText: 'Quận / huyện',
        filled: false,
      ),
      readOnly: true,
      onTap: _province != null ? _showDisctrictDialog : null,
    );
  }

  Widget _selectWard() {
    return TextField(
      controller: TextEditingController(text: _wardTitle),
      decoration: InputDecoration(
        hintText: 'Phường / xã',
        labelText: 'Phường / xã',
        filled: false,
      ),
      readOnly: true,
      onTap: _disctrict != null ? _showWardDialog : null,
    );
  }

  Widget _addressField() {
    return TextField(
      controller: TextEditingController(text: _address),
      decoration: InputDecoration(
        hintText: 'Địa chỉ cụ thể',
        labelText: 'Địa chỉ cụ thể',
        filled: false,
      ),
    );
  }
}
