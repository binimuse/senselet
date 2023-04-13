class LangMutation {
  static const String changelang = r'''
mutation changeLang($langCode: String!){
  changeLang(langCode: $langCode) {
       data
    {
      langCode
    }
    tokens
    {
      access_token
      refresh_token
    }
  }
}
 ''';
}
