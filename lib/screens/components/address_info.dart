import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/Location/Address.dart';
import 'package:cntt2_crm/models/Location/City.dart';
import 'package:cntt2_crm/models/Location/District.dart';
import 'package:cntt2_crm/models/Location/Ward.dart';
import 'package:flutter/material.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class AddressInfo extends StatefulWidget {
  final Address address;
  final GlobalKey<FormState> formKey;
  final bool canEdit;

  const AddressInfo({
    Key key,
    @required this.address,
    @required this.formKey,
    this.canEdit = true,
  }) : super(key: key);
  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  City _city;
  District _district;
  Ward _ward;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _selectCity(),
          SizedBox(height: Layouts.SPACING),
          _selectDisctrict(),
          SizedBox(height: Layouts.SPACING),
          _selectWard(),
          SizedBox(height: Layouts.SPACING),
          _addressField(),
        ],
      ),
    );
  }

  Widget _selectCity() {
    return TextFormField(
      enabled: widget.canEdit,
      controller: TextEditingController(
        text: widget.address.city != null ? widget.address.city : '',
      ),
      decoration: InputDecoration(
        labelText: 'Tỉnh / thành phố',
        filled: false,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      readOnly: true,
      onTap: _showCityDialog,
      validator: (_) {
        if (widget.address.cityCode == null) {
          return 'Vui lòng chọn tỉnh/thành phố';
        }
        return null;
      },
    );
  }

  Widget _selectDisctrict() {
    return TextFormField(
      controller: TextEditingController(
        text: widget.address.district != null ? widget.address.district : '',
      ),
      decoration: InputDecoration(
        labelText: 'Quận / huyện',
        filled: false,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      readOnly: true,
      enabled: (widget.canEdit && _city != null) ? true : false,
      onTap: _showDisctrictDialog,
      validator: (_) {
        if (widget.address.districtCode == null) {
          return 'Vui lòng chọn quận/huyện';
        }
        return null;
      },
    );
  }

  Widget _selectWard() {
    return TextFormField(
      controller: TextEditingController(
        text: widget.address.ward != null ? widget.address.ward : '',
      ),
      decoration: InputDecoration(
        labelText: 'Phường / xã',
        filled: false,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      readOnly: true,
      enabled: (widget.canEdit && _district != null) ? true : false,
      onTap: _showWardDialog,
      validator: (_) {
        if (widget.address.wardCode == null) {
          return 'Vui lòng chọn phường/xã';
        }
        return null;
      },
    );
  }

  Widget _addressField() {
    return TextFormField(
      enabled: widget.canEdit,
      controller: TextEditingController(text: widget.address.address),
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Địa chỉ cụ thể',
        filled: false,
      ),
      onChanged: (value) {
        widget.address.address = value;
      },
      validator: (_) {
        if (widget.address.address == null || widget.address.address.isEmpty) {
          return 'Vui lòng nhập địa chỉ';
        }
        return null;
      },
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
          widget.address.city = _city.name;
          widget.address.cityCode = _city.id;

          _district = null;
          widget.address.district = null;
          widget.address.districtCode = null;

          _ward = null;
          widget.address.ward = null;
          widget.address.wardCode = null;
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
          widget.address.district = _district.name;
          widget.address.districtCode = _district.id;

          _ward = null;
          widget.address.ward = null;
          widget.address.wardCode = null;
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
          widget.address.ward = _ward.name;
          widget.address.wardCode = _ward.id;
        });
      },
    );
  }
}
