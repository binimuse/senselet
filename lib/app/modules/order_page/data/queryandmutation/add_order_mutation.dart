class AddOrderMutation {
  static const String addOrder = r'''
    mutation  insert_orders(
    $delivery_location: geography!,
      $pickup_location: geography!,
      $vehicle_type_id: uuid!,
      $detail: String!,
      $delivery_location_name: String!,
      $pickup_location_name:String!){
      action: insert_orders(objects: {
     
          delivery_location: $delivery_location
          pickup_location: $pickup_location
          delivery_location_name: $delivery_location_name
          pickup_location_name: $pickup_location_name
          vehicle_type_id: $vehicle_type_id
          detail: $detail
         
           }){
 affected_rows
      }
    }
 ''';
}
