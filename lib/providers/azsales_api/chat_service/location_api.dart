import 'package:cntt2_crm/models/Location/City.dart';
import 'package:cntt2_crm/models/Location/District.dart';
import 'package:cntt2_crm/models/Location/Ward.dart';
import 'package:cntt2_crm/providers/azsales_api/url_api.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class LocationAPI {
  static Future<List<City>> fetchAllCity() async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          location {
            cities {
              _id
              label
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getShippingClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> citiesJson = response.data['location']['cities'];
      List<City> cities = List.empty(growable: true);
      citiesJson.forEach((city) {
        cities.add(City.fromJson(city));
      });
      return cities;
    }
  }

  static Future<List<District>> fetchAllDistrict({
    @required City city,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          location {
            districts(filter: {city_code: ${city.id}}) {
              _id
              label,
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getShippingClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> districtsJson = response.data['location']['districts'];
      List<District> districts = List.empty(growable: true);
      districtsJson.forEach((district) {
        districts.add(District.fromJson(city, district));
      });
      return districts;
    }
  }

  static Future<List<Ward>> fetchAllWard({
    @required District district,
  }) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        '''
        query {
          location {
            wards(filter: {district_code: ${district.id}}) {
              _id,
              label
            }
          }
        }
        ''',
      ),
    );
    final GraphQLClient client = getShippingClient();
    final response = await client.query(options);
    if (response.hasException) {
      print(response.exception.toString());
      return null;
    } else {
      List<dynamic> wardsJson = response.data['location']['wards'];
      List<Ward> wards = List.empty(growable: true);
      wardsJson.forEach((ward) {
        wards.add(Ward.fromJson(district, ward));
      });
      return wards;
    }
  }
}
