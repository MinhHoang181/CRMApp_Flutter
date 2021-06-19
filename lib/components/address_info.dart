import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Location/City.dart';
import 'package:cntt2_crm/models/Location/District.dart';
import 'package:cntt2_crm/models/Location/Ward.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class AddressInfo extends StatefulWidget {
  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  City _city;
  District _district;
  Ward _ward;
  String _address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectCity(),
        SizedBox(height: Layouts.SPACING),
        _selectDisctrict(),
        SizedBox(height: Layouts.SPACING),
        _selectWard(),
        SizedBox(height: Layouts.SPACING),
        _addressField(),
      ],
    );
  }

  Widget _selectCity() {
    return TextField(
      controller: TextEditingController(
        text: _city != null ? _city.toString() : '',
      ),
      decoration: InputDecoration(
        labelText: 'Tỉnh / thành phố',
        filled: false,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      readOnly: true,
      onTap: _showCityDialog,
    );
  }

  Widget _selectDisctrict() {
    return TextField(
      controller: TextEditingController(
        text: _district != null ? _district.toString() : '',
      ),
      decoration: InputDecoration(
        labelText: 'Quận / huyện',
        filled: false,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      readOnly: true,
      enabled: _city != null ? true : false,
      onTap: _showDisctrictDialog,
    );
  }

  Widget _selectWard() {
    return TextField(
      controller: TextEditingController(
        text: _ward != null ? _ward.toString() : '',
      ),
      decoration: InputDecoration(
        labelText: 'Phường / xã',
        filled: false,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      readOnly: true,
      enabled: _district != null ? true : false,
      onTap: _showWardDialog,
    );
  }

  Widget _addressField() {
    return TextField(
      controller: TextEditingController(text: _address),
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Địa chỉ cụ thể',
        filled: false,
      ),
    );
  }

  Widget _cityItem(City city) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Text(
        city.name,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Widget _districtItem(District district) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Text(
        district.name,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Widget _wardItem(Ward ward) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Text(
        ward.name,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  void _showCityDialog() {
    SelectDialog.showModal<City>(
      context,
      titleStyle: Theme.of(context).textTheme.subtitle1,
      label: 'Chọn tỉnh / thành phố',
      selectedValue: _city,
      searchBoxDecoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        filled: false,
        labelText: 'Nhập tên tỉnh/thành phố',
      ),
      items: AzsalesData.instance.location.cities,
      itemBuilder: (context, item, isSelected) {
        return _cityItem(item);
      },
      onChange: (selected) {
        setState(() {
          _city = selected;
          _district = null;
          _ward = null;
        });
      },
    );
  }

  void _showDisctrictDialog() async {
    SelectDialog.showModal(
      context,
      showSearchBox: false,
      label: 'Chọn Quận / huyện',
      selectedValue: _district,
      items: await _city.districts,
      itemBuilder: (context, item, isSelected) {
        return _districtItem(item);
      },
      onChange: (selected) {
        setState(() {
          _district = selected;
          _ward = null;
        });
      },
    );
  }

  void _showWardDialog() async {
    SelectDialog.showModal(
      context,
      showSearchBox: false,
      label: 'Chọn Phường / xã',
      selectedValue: _ward,
      items: await _district.wards,
      itemBuilder: (context, item, isSelected) {
        return _wardItem(item);
      },
      onChange: (selected) {
        setState(() {
          _ward = selected;
        });
      },
    );
  }
}
