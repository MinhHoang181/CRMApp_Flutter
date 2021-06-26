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
      city: json['city'] != null ? json['city']['label'] : null,
      cityCode: json['city'] != null ? json['city']['_id'] : null,
      district: json['district'] != null ? json['district']['label'] : null,
      districtCode: json['district'] != null ? json['district']['_id'] : null,
      ward: json['ward'] != null ? json['ward']['label'] : null,
      wardCode: json['ward'] != null ? json['ward']['_id'] : null,
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
