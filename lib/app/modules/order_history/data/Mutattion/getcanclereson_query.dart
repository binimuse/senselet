class GetCancellationreasonsQuery {
  static dynamic getcancellationreasons() {
    return '''
query{
  cancellation_reasons(where: {source: {_eq: CUSTOMER}}) {
    name
    description
    id
    source
  }
}



 ''';
  }
}
