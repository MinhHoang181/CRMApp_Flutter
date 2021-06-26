class Address {
  String address;
  String city;
  int cityCode;
  String district;
  int districtCode;
  String ward;
  int wardCode;

  bool get hasAddress =>
      cityCode != null &&
      districtCode != null &&
      wardCode != null &&
      address != null;

  String get fullAddress {
    if (city == null || district == null || ward == null) {
      return null;
    }
    return address + ', ' + ward + ', ' + district + ', ' + city;
  }

  Address({
    this.address,
    this.city,
    this.cityCode,
    this.district,
    this.districtCode,
    this.ward,
    this.wardCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      cityCode: json['city_code'],
      districtCode: json['district_code'],
      wardCode: json['ward_code'],
    );
  }

  factory Address.fromJsonLocation(String address, Map<String, dynamic> json) {
    return Address(
      address: address,
      city: json['cityById'] != null ? json['cityById']['label'] : null,
      cityCode: json['cityById'] != null ? json['cityById']['_id'] : null,
      district:
          json['districtById'] != null ? json['districtById']['label'] : null,
      districtCode:
          json['districtById'] != null ? json['districtById']['_id'] : null,
      ward: json['wardById'] != null ? json['wardById']['label'] : null,
      wardCode: json['wardById'] != null ? json['wardById']['_id'] : null,
    );
  }

  void copy(Address address) {
    this.address = address.address;
    this.city = address.city;
    this.cityCode = address.cityCode;
    this.district = address.district;
    this.districtCode = address.districtCode;
    this.ward = address.ward;
    this.wardCode = address.wardCode;
  }
}
