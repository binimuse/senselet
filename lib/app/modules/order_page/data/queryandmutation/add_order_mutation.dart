class AddOrderMutation {
  static const String addOrder = r'''
    mutation  insert_orders($pickup_location_lat: float8! $pickup_location_lng:float8!, $delivery_location_lat:float8!, $delivery_location_lng:float8!,
    $delivery_location: String!,$pickup_location: String!,$vehicle_type_id: uuid!,$detail: String! ){
      action: insert_orders(objects: {
         name: $name,
          pickup_location_lat: $pickup_location_lat,
          pickup_location_lng: $pickup_location_lng,
          delivery_location_lat: $delivery_location_lat
          delivery_location_lng: $delivery_location_lng
          delivery_location: $delivery_location
          pickup_location: $pickup_location
          vehicle_type_id: $vehicle_type_id
          detail: $detail
         
           }){
 affected_rows
      }
    }
 ''';
}
