class GetConstatsQuery {
  static dynamic getConstats() {
    return """
{
  constants {
    id
    address
    phone
    short_code
    tone_price
    tone_price
    fb_id
    telegram_id
    website
    about_us
  }
}

    """;
  }
}
