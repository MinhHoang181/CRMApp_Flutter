import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/list_model/VariantList.dart';
import 'package:flutter/material.dart';

import 'Variant.dart';

class Product {
  final String id;
  final int numberId;
  final String name;
  var _price;
  double get price => _price != null ? _price.toDouble() : null;
  var _inPrice;
  double get inPrice => _inPrice != null ? _inPrice.toDouble() : null;
  var _salePrice;
  double get salePrice => _salePrice != null ? _salePrice.toDouble() : null;
  final List<Photo> photos;
  final VariantList variants;
  final int total;

  double get finalPrice => salePrice != null ? salePrice : price;

  Product({
    @required this.id,
    @required this.numberId,
    @required this.name,
    @required price,
    @required inPrice,
    @required salePrice,
    @required this.photos,
    @required this.variants,
    @required this.total,
  }) {
    this._price = price;
    this._inPrice = inPrice;
    this._salePrice = salePrice;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> photosJson = json['photos'];
    List<Photo> photos = List.empty(growable: true);
    photosJson.forEach((photo) {
      photos.add(Photo.fromJson(photo));
    });
    return Product(
      id: json['_id'],
      numberId: json['id'],
      name: json['name'],
      price: json['price'],
      inPrice: json['in_price'],
      salePrice: json['sale_price'],
      photos: photos,
      variants: new VariantList(productId: json['_id']),
      total: json['stockData'] != null ? json['stockData']['total'] : 0,
    );
  }

  factory Product.fromJsonSearch(Map<String, dynamic> json) {
    List<dynamic> photosJson = json['photos'];
    List<Photo> photos = List.empty(growable: true);
    photosJson.forEach((photo) {
      photos.add(Photo.fromJson(photo));
    });

    final product = Product(
      id: json['_id'],
      numberId: json['id'],
      name: json['name'],
      price: json['price'],
      inPrice: json['in_price'],
      salePrice: json['sale_price'],
      photos: photos,
      variants: new VariantList(productId: json['_id']),
      total: json['stockData'] != null ? json['stockData']['total'] : 0,
    );

    List<Variant> variants = List.empty(growable: true);
    List<dynamic> variantsJson = json['variants'];
    variantsJson.forEach((variant) {
      Map<String, dynamic> total = json['stockData'];
      variants.add(Variant.fromJson(product, variant, total));
    });
    product.variants.fetchData(list: variants);
    return product;
  }

  @override
  operator ==(o) => o is Product && o.id == id;
  @override
  int get hashCode => id.hashCode;
}
