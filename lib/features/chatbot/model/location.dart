class Location {
  double lat;
  double lon;

  Location({
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'] ?? 0,
      lon: map['lon'] ?? 0,
    );
  }
}
