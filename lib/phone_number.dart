class PhoneNumber {
  
  // Put your code here
  String clean(String number){
    String cleanNumber = '';

    List<String> allowedToSkip = [' ', '-', '.', '(', ')', '+'];
    for(int i=0; i<number.length; ++i){
      String c = number[i];

      if(allowedToSkip.contains(c)) continue;
      if(!(c.codeUnitAt(0)>47 && c.codeUnitAt(0)<58)) {
        throw(_getExceptionForError(ErrorType.NotADigit, number: c));
      }
      cleanNumber += c;
    }
    
    dynamic validNumber = _getValidNumber(cleanNumber);

    if(validNumber is ErrorType) throw(_getExceptionForError(validNumber));
    else return validNumber.toString();
  }

  dynamic _getValidNumber(String cleanNumber){
    if(cleanNumber.length > 11) return ErrorType.TooManyDigits;
    if(cleanNumber.length < 10) return ErrorType.NotEnoughDigits;

    if(cleanNumber.length == 11){
      if(cleanNumber[0] != '1') return ErrorType.IntCountryCodeIsNotOne;
      cleanNumber = cleanNumber.substring(1);
    } 

    if(cleanNumber[0] == '0') return ErrorType.AreaCodeIsZero;
    if(cleanNumber[0] == '1') return ErrorType.AreCodeIsOne;

    if(cleanNumber[3] == '0') return ErrorType.ExchangeCodeIsZero;
    if(cleanNumber[3] == '1') return ErrorType.ExchangeCodeIsOne;
    
    return cleanNumber;
  }

  FormatException _getExceptionForError(ErrorType error, {String number:''}){
    switch (error) {
      case ErrorType.NotADigit:
        if(number.contains(new RegExp('[@|:|!]+'))) return FormatException('punctuations not permitted');
        if(number.contains(new RegExp('[a-zA-Z]+'))) return FormatException('letters not permitted');
        break;
      case ErrorType.IntCountryCodeIsNotOne:
        return FormatException('11 digits must start with 1');
      case ErrorType.NotEnoughDigits:
        return FormatException('incorrect number of digits');
      case ErrorType.TooManyDigits:
        return FormatException('more than 11 digits');
      case ErrorType.AreaCodeIsZero:
        return FormatException('area code cannot start with zero');
      case ErrorType.AreCodeIsOne:
        return FormatException('area code cannot start with one');
      case ErrorType.ExchangeCodeIsZero:
        return FormatException('exchange code cannot start with zero');
      case ErrorType.ExchangeCodeIsOne:
        return FormatException('exchange code cannot start with one');
      default:
        break;
    }

    return FormatException('Unhandled error type when invalid number');
  }

}

enum ErrorType{
  NotADigit,
  IntCountryCodeIsNotOne,
  NotEnoughDigits,
  TooManyDigits,
  AreaCodeIsZero,
  AreCodeIsOne,
  ExchangeCodeIsZero,
  ExchangeCodeIsOne
}