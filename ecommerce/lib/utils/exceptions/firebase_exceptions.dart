class TFirebaseException implements Exception{
  final String code;

  TFirebaseException(this.code);
  String get message{
    switch(code){
      case 'unknown':
        return'An unknown Firebase error occurred.Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect.Please check your custom token.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to different audience.';
      case 'user-disabled':
        return'This user account has been disabled. Please contact support for assistance. ';
      case 'user-not-found':
        return'Invalid login details.User not found';
      case 'email-already-in-use':
        return'The email address is already registered.Please use different email.';
      case 'invalid-email':
        return 'The email address provided is invalid.Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak.Please chose a stronger password.';
      case 'wrong-password':
        return'Incorrect password.Please check your password and try again. ';
      case 'invalid-verification-id':
        return'Invalid verification ID.Please request a new verification code. ';
      case'invalid-verification-code':
        return'Invalid verification code.Please enter a valid code.';
      case'operation-not-allowed':
        return'This operation is not allowed.Contact support for assistance.';
      case 'captcha-check-failed ':
        return'The reCAPTCHA response is invalid. Please try again.';
      case 'app-not-authorized':
        return'The app is not authorized to use Firebase Authentication with the provided API key.';
      case'keychain-error':
        return'A keychain error occurred.Please check the keychain and try again. ';
      case 'quota-exceeded':
        return'Quota exceeded.Please try again later. ';
      case 'provider-already-linked':
        return'The account is already linked with anther provider';

      case'invalid-credential':
        return'Invalid supplied credential is malformed or has expired.';
      default:
        return'An unexpected Firebase error occurred.Please try again.';


    }
  }
}