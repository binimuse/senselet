class CancleOrdermuatation {
  static const String cancleOrdermuatation = r'''
mutation updateOrderAndAssignedHistoriesByPk($id: uuid!, $cancellation_reason: String!,$oid: uuid!) {
  update_order_assigned_histories_by_pk(pk_columns: {id: $id}, 
  _set: {canceled: true, cancellation_reason: $cancellation_reason}) {
    canceled
  }
  update_orders_by_pk(pk_columns: {id: $oid},
   _set: {assigned: false,
    order_status: CANCELED_BY_DRIVER,
    assigned_to_id: null, 
    order_assigned_history_id: null,
    assigning: true})
  {
    assigned
  }

}

 ''';
}
