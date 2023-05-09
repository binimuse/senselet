class GetNearbyvehicleQuery {
  static dynamic getGetNearbyvehicleQuery(
      int distance, double lat, double lng) {
    return """
query GetNearbyPlaces {
  vehicles(where: { location: { _st_d_within: { distance: $distance, from: { type: "Point", coordinates: [$lat,$lng] } } } }) {
plate_number
    vehicle_type
    {
      id
      name
      kg
      description   
    }
    id
    photos
    location
    plate_number
  }
}

    """;
  }
}
