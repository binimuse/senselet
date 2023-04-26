// ignore_for_file: file_names

class GetvehicletypesQuery {
  static dynamic getvehicletypesmodel() {
    return '''
query MyQuery {
  vehicle_types {
    created_at
    description
    id
    kg
    name
    prefix
  }
}


 ''';
  }
}
