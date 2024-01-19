import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class AuthService{
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      if (guser != null) {
        print('google sign in user: $guser');

        final GoogleSignInAuthentication gauth = await guser!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: gauth.accessToken,
            idToken: gauth.idToken,
          );
          final UserCredential authResult = await _auth.signInWithCredential(credential);
          return authResult.user;
        }

    }
    catch(e){
      print('Error signing in with Google: $e');

    }
    return null;
  }
}