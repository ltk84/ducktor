class Address {
  String streetNumber;
  String streetName;
  String district;
  String city;

  Address({
    required this.streetNumber,
    required this.streetName,
    required this.district,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'street_number': streetNumber,
      'street_name': streetName,
      'district': district,
      'city': city,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      streetNumber: map["street_number"] ?? '',
      streetName: map["street_name"] ?? '',
      district: map["district"] ?? '',
      city: map["city"] ?? '',
    );
  }

  @override
  String toString() {
    return "$streetNumber $streetName, $district, $city";
  }
}
