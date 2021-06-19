import 'package:cntt2_crm/models/Location/City.dart';
import 'package:cntt2_crm/providers/azsales_api/chat_service/location_api.dart';

class Location {
  Map<int, City> _list;
  List<City> cities;

  Future<Location> fetchData() async {
    if (_list == null) {
      _list = new Map<int, City>();
      cities = await LocationAPI.fetchAllCity();
      if (cities != null) {
        cities.forEach((city) {
          _list.putIfAbsent(city.id, () => city);
        });
      }
    }
    return this;
  }

  City getCity(int id) => _list[id];
}
