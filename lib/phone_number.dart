class PhoneNumber {

  ExceptionHandler exception = ExceptionHandler();

  String clean(String number){
    RegExp skipableChars = RegExp('[ -.()+]');
    String leanNumber = number.replaceAll(skipableChars, '');

    _containsOnlyDigits(leanNumber);
    _hasCorrectSize(leanNumber);

    leanNumber =  _removeCountryCode(leanNumber);

    _hasCorrectAreaCode(leanNumber);
    _hasCorrectExchangeCode(leanNumber);

    return leanNumber;
  }

  void _containsOnlyDigits(String number){
    RegExp letterChars = RegExp('[a-zA-Z]');
    if(number.contains(letterChars)) throw(exception.of(ErrorType.ContainsLetters));

    RegExp punctuationChars = RegExp('[@:!]');
    if(number.contains(punctuationChars)) throw(exception.of(ErrorType.ContainsPunctuation));

    RegExp nonDigitChars = RegExp('\D');
    if(number.contains(nonDigitChars)) throw(exception.of(ErrorType.NonOnlyDigits));
  }

  void _hasCorrectSize(String number){
    if(number.length > 11) throw(exception.of(ErrorType.TooManyDigits));
    if(number.length < 10) throw(exception.of(ErrorType.NotEnoughDigits));
  }

  String _removeCountryCode(String number){
    if(number.length == 11){
      if(!number.startsWith('1')) throw(exception.of(ErrorType.IntCountryCodeIsNotOne));
      number = number.substring(1);
    }
    return number;
  }

  void _hasCorrectAreaCode(String number){
    if(number.length == 11) number = number.substring(1);

    if(number.startsWith('0')) throw(exception.of(ErrorType.AreaCodeIsZero));
    if(number.startsWith('1')) throw(exception.of(ErrorType.AreaCodeIsOne));
  }

  void _hasCorrectExchangeCode(String number){
    if(number.length == 11) number = number.substring(1);

    if(number[3] == '0') throw(exception.of(ErrorType.ExchangeCodeIsZero));
    if(number[3] == '1') throw(exception.of(ErrorType.ExchangeCodeIsOne));
  }

}


class ExceptionHandler {

  final Map<ErrorType, Exception> _exceptions = {
    ErrorType.ContainsLetters : FormatException('letters not permitted'),
    ErrorType.ContainsPunctuation : FormatException('punctuations not permitted'),
    ErrorType.NonOnlyDigits : FormatException('non digits chars used in string'),
    ErrorType.IntCountryCodeIsNotOne : FormatException('11 digits must start with 1'),
    ErrorType.NotEnoughDigits : FormatException('incorrect number of digits'),
    ErrorType.TooManyDigits : FormatException('more than 11 digits'),
    ErrorType.AreaCodeIsZero : FormatException('area code cannot start with zero'),
    ErrorType.AreaCodeIsOne : FormatException('area code cannot start with one'),
    ErrorType.ExchangeCodeIsZero : FormatException('exchange code cannot start with zero'),
    ErrorType.ExchangeCodeIsOne : FormatException('exchange code cannot start with one'),
    ErrorType.UnhandledError : FormatException('unhandled error type when invalid number')
  };

  Exception of(ErrorType error){
    Exception exception;

    if(_exceptions.containsKey(error)) exception = _exceptions[error];
    else exception = _exceptions[ErrorType.UnhandledError];

    return exception;
  }
 
}

enum ErrorType{
  ContainsLetters,
  ContainsPunctuation,
  NonOnlyDigits,
  IntCountryCodeIsNotOne,
  NotEnoughDigits,
  TooManyDigits,
  AreaCodeIsZero,
  AreaCodeIsOne,
  ExchangeCodeIsZero,
  ExchangeCodeIsOne,
  UnhandledError
}