///custom exception class to handle various format related errors
class TFormatException implements Exception{
 ///the associated error message
  final String message;
  ///default constructor with a generic error message
  const TFormatException([this.message='An unexpected format error occurred.Please check your input']);
  ///create a format exception from a specific error message
  factory TFormatException.formMessage(String message){
    return TFormatException(message);
  }
  ///Get the corresponding error message
  String get formattedMessage=>message;
  ///create a format exception from a specific error code
  factory TFormatException.fromCode(String code){
    switch(code){
      case 'invalid-email-format':
        return const TFormatException ('The email address format is invalid.Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const TFormatException('The provided phone number is invalid.Please enter a valid number.');
      case 'invalid-date-format':
        return const TFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const TFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const TFormatException('The credit card format is invalid. Please enter a valid credit card.');
      case 'invalid-numeric-format':
        return const TFormatException('The input should be valid numeric format');
      default:
        return const TFormatException();


    }

  }



}