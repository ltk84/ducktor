import 'package:ducktor/features/chatbot/model/address.dart';
import 'package:ducktor/features/chatbot/model/location.dart';

class LocationData {
  Address address;
  Location location;
  String name;

  LocationData({
    required this.address,
    required this.location,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address.toMap(),
      'location': location.toMap(),
      'name': name,
    };
  }

  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      address: Address.fromMap(map["address"] ?? {}),
      location: Location.fromMap(map["location"] ?? {}),
      name: map["name"] ?? '',
    );
  }
}
