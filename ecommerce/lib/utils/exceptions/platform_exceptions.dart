class TPlatformException implements Exception{
  final String code;

  TPlatformException(this.code);
  String get message{
    switch(code){
      case 'INVALID-LOGIN-CREDENTIALS':
        return'Invalid login credentials .Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests.Please try again latter.';
      case 'invalid arguments':
        return 'Invalid argument provided to authentication method.';
      case 'user-disabled':
        return'This user account has been disabled. Please contact support for assistance. ';
      case 'user-not-found':
        return'Invalid login details.User not found';
      case 'invalid-password':
        return'Incorrect password.Please check your password and try again. ';
      case'invalid-phone-number':
        return'The provided phone number is invalid.';
      case'operation-not-allowed':
        return'The sign0in provider is disabled for your Firebase project.';
      case'session-cookie-expired':
        return'The Firebase session cookie has expired.Please sign-in again';
      case'uid-already-exists':
        return 'The provided user ID is already in use by anther user.';
      case'sign-in-failed':
        return'Sign-in failed.Please try again';
      case'network-request-failed':
        return 'Network request failed.Please check your internet connection.';
      case'Internal-error':
        return'Internal error.Please try again later';
      case'invalid-verification-id':
        return'Invalid verification ID.Please request a new verification code. ';
      case 'quota-exceeded':
        return'Quota exceeded.Please try again later. ';
      case 'provider-already-linked':
        return'The account is already linked with anther provider';
      case'invalid-credential':
        return'Invalid supplied credential is malformed or has expired.';
      case'invalid-verification-code':
        return'Invalid verification code.Please enter a valid code.';
      default:
        return'An unexpected Firebase error occurred.Please try again.';


    }
  }
}