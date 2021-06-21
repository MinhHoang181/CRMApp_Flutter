import 'package:cntt2_crm/models/Product/Photo.dart';
import 'package:cntt2_crm/models/list_model/VariantList.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final int numberId;
  final String name;
  final int price;
  final int inPrice;
  final int salePrice;
  final List<Photo> photos;
  final VariantList variants;

  Product({
    @required this.id,
    @required this.numberId,
    @required this.name,
    @required this.price,
    @required this.inPrice,
    @required this.salePrice,
    @required this.photos,
    @required this.variants,
  });

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
    );
  }
}
