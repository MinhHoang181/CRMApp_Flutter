import 'package:cntt2_crm/models/PageInfo.dart';
import 'package:cntt2_crm/models/Product/Product.dart';
import 'package:cntt2_crm/models/Product/Variant.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:tuple/tuple.dart';

class ProductAPI {
  static Future<Tuple2<List<Product>, PageInfo>> fetchProductPaging({
    int page = 1,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          product {
            productsPaging(page: $page, sort: ID_DESC) {
              pageInfo {
                hasNextPage,
                currentPage,
              }
              items {
                _id,
                id,
                name,
                price,
                in_price,
                sale_price,
                featured_photo {
                  _id
                  url
                }
                photos {
                  _id,
                  url,
                }
                stockData {
                  total,
                }
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> productsJson =
          response.data['product']['productsPaging']['items'];
      List<Product> products = List.empty(growable: true);
      productsJson.forEach((product) {
        products.add(Product.fromJson(product));
      });
      Map<String, dynamic> pageInfo =
          response.data['product']['productsPaging']['pageInfo'];
      return Tuple2(products, PageInfo.fromJson(pageInfo));
    }
  }

  static Future<List<Product>> fetchProducts({String text = ''}) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          product {
            lookup(text: "$text") {
              _id
              id
              name
              price
              in_price
              sale_price
              featured_photo {
                _id
                url
              }
              photos {
                _id
                url
              }
              variants {
                id
                barcode
                price
                in_price
                sale_price
                attributes {
                  name
                  value
                }
              }
              stockData {
                total
                qty_by_variant
              }
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> productsJson = response.data['product']['lookup'];
      List<Product> products = List.empty(growable: true);
      productsJson.forEach((product) {
        products.add(Product.fromJsonSearch(product));
      });
      return products;
    }
  }

  static Future<List<Variant>> fetchVariantOfProduct({
    @required Product product,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          product {
            productById(_id: "${product.id}") {
              variants {
                id
                barcode
                price
                in_price
                sale_price
                attributes {
                  name
                  value
                }
              }
            }
            productQtyById(_id: "${product.id}") {
              qty_by_variant
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getPosClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<Variant> variants = List.empty(growable: true);
      if (response.data['product']['productById'] == null) return variants;

      List<dynamic> variantsJson =
          response.data['product']['productById']['variants'];

      variantsJson.forEach((variant) {
        Map<String, dynamic> total = response.data['product']['productQtyById'];
        variants.add(Variant.fromJson(product, variant, total));
      });
      return variants;
    }
  }
}
