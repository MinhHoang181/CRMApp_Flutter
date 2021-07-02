import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Product/Product.dart';

class ProductMessage extends ChangeNotifier {
  Product _product;
  Product get product => _product;
  set product(Product value) {
    _product = value;
    _photos.clear();
    _varaints.clear();
    notifyListeners();
  }

  Map<String, Photo> _photos = Map<String, Photo>();
  List<String> get photos => _photos.values.map((photo) => photo.url).toList();
  Map<int, Variant> _varaints = Map<int, Variant>();

  bool _hasPhoto = true;
  bool get hasPhoto => _hasPhoto;
  set hasPhoto(bool value) {
    _hasPhoto = value;
    notifyListeners();
  }

  bool _hasPrice = false;
  bool get hasPrice => _hasPrice;
  set hasPrice(bool value) {
    _hasPrice = value;
    notifyListeners();
  }

  bool _hasAttribute = false;
  bool get hasAttribute => _hasAttribute;
  set hasAttribute(bool value) {
    _hasAttribute = value;
    notifyListeners();
  }

  bool addPhoto(Photo photo) {
    if (!_photos.containsKey(photo.id)) {
      _photos[photo.id] = photo;
      //notifyListeners();
      return true;
    }
    return false;
  }

  bool removePhoto(Photo photo) {
    if (_photos.containsKey(photo.id)) {
      _photos.remove(photo.id);
      //notifyListeners();
      return true;
    }
    return false;
  }

  bool containPhoto(Photo photo) {
    return _photos.containsKey(photo.id);
  }

  bool addVariant(Variant variant) {
    if (!_varaints.containsKey(variant.id)) {
      _varaints[variant.id] = variant;
      return true;
    }
    return false;
  }

  bool removeVariant(Variant variant) {
    if (_varaints.containsKey(variant.id)) {
      _varaints.remove(variant.id);
      return true;
    }
    return false;
  }

  bool containVariant(Variant variant) {
    return _varaints.containsKey(variant.id);
  }

  //TEST
  String get photosToString {
    String text = '';
    _photos.forEach((key, value) {
      text += value.id + ' / ';
    });
    return text;
  }

  String get toMessage {
    String name = '${product.name}';
    String id = '\nMã sản phẩm: ${product.numberId}';
    String message = name + id + _price + _attribute;
    return message;
  }

  String get _price {
    String text = '';
    if (_hasPrice) {
      if (!_hasAttribute || (_hasAttribute && _varaints.isEmpty)) {
        text = '\nGiá: ' + NumberFormat('#,### đ').format(product.finalPrice);
      }
    }
    return text;
  }

  String get _attribute {
    String attributes = '';
    if (_hasAttribute) {
      attributes = '\nMẫu mã:';
      _varaints.values.forEach((variant) {
        final priceText =
            _hasPrice ? NumberFormat('#,### đ').format(variant.finalPrice) : '';
        final attribute = '\n${variant.attributesToString()}       $priceText';
        attributes += attribute;
      });
    }
    return attributes;
  }
}
