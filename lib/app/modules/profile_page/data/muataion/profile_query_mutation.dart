class UpdateProfileQueryMutation {
  static const String updateusers = r''' 
    mutation update_users($id: Int!, $phone: String!, $email: String!, $dob: String!, $first_name: String!, $last_name: String!, $gender: genders_enum,){
      update_users(where: {id: {_eq: $id}}, _set: {
        phone: $phone, 
        email: $email, 
        dob: $dob, 
        first_name: $first_name, 
        gender: $gender, 
        last_name:  $last_name
        }) {
      returning {
      id
    }
    }
    }
    ''';
}

class GetuserProfile {
  dynamic getuser() {
    return """
              query  {
                auth {
                  first_name
                  last_name
                  phone
                  gender
                  email
                  dob
                  avatar       
                }
              }
    """;
  }

  dynamic getuserSub(int userId) {
    return """
      subscription 
         {
  users_by_pk(id: $userId) {
     first_name
                  last_name
                  phone
                  gender
                  email
                  dob
                  avatar 
  }
      }
    """;
  }
}

class GetcmsData {
  dynamic getcmsdatabypk(int userId) {
    return """
      query 
         {
  cms_data_by_pk(id: $userId) {
    data 

  }
      }
    """;
  }
}

class GetFaqData {
  dynamic getFaqData() {
    return """
      query 
         {
  faq {
       id
    question
    answer 

  }
      }
    """;
  }
}
