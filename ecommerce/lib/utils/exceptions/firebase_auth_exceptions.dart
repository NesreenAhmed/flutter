
class TFirebaseAuthException implements Exception{
  final String code;

  TFirebaseAuthException(this.code);
  String get message{
    switch(code){
      case 'email-already-in-use':
        return'The email address is already registered.Please use different email.';
      case 'invalid-email':
        return 'The email address provided is invalid.Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak.Please chose a stronger password.';
      case 'user-disabled':
        return'This user account has been disabled. Please contact support for assistance. ';
      case 'user-not-found':
        return'Invalid login details.User not found';
      case 'wrong-password':
        return'Incorrect password.Please check your password and try again. ';
      case'invalid-verification-id':
        return'Invalid verification ID.Please request a new verification code. ';
      case 'quota-exceeded':
        return'Quota exceeded.Please try again later. ';
      case 'provider-already-linked':
        return'The account is already linked with anther provider';
      case'operation-not-allowed':
        return'This operation is not allowed.Contact support for assistance.';
      case'invalid-credential':
        return'Invalid supplied credential is malformed or has expired.';
      case'invalid-verification-code':
        return'Invalid verification code.Please enter a valid code.';
     default:
       return'An unexpected Firebase error occurred.Please try again.';


    }
  }
}