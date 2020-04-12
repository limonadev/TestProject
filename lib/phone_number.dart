class PhoneNumber {
  String clean(String number) {
    RegExp skipableChars = RegExp('[ -.()+]');
    String leanNumber = number.replaceAll(skipableChars, '');

    _containsOnlyDigits(leanNumber);
    _hasCorrectSize(leanNumber);

    leanNumber = _removeCountryCode(leanNumber);

    _hasCorrectAreaCode(leanNumber);
    _hasCorrectExchangeCode(leanNumber);

    return leanNumber;
  }

  void _containsOnlyDigits(String number) {
    if (number.contains(RegExp('[a-zA-Z]')))
      throw FormatException('letters not permitted');

    if (number.contains(RegExp('[@:!]')))
      throw FormatException('punctuations not permitted');
  }

  void _hasCorrectSize(String number) {
    if (number.length > 11) throw FormatException('more than 11 digits');
    if (number.length < 10) throw FormatException('incorrect number of digits');
  }

  String _removeCountryCode(String number) {
    if (number.length == 11) {
      if (!number.startsWith('1')) throw FormatException('11 digits must start with 1');
      number = number.substring(1);
    }
    return number;
  }

  void _hasCorrectAreaCode(String number) {
    if (number.startsWith('0')) throw FormatException('area code cannot start with zero');
    if (number.startsWith('1')) throw FormatException('area code cannot start with one');
  }

  void _hasCorrectExchangeCode(String number) {
    if (number[3] == '0') throw FormatException('exchange code cannot start with zero');
    if (number[3] == '1') throw FormatException('exchange code cannot start with one');
  }
}