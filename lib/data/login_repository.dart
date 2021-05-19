import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  /// Throws [NetworkException].
  Future<List<String>> fetchLogin(String email, String password);
}

class FakeLoginRepository implements LoginRepository {
  @override
  Future<List<String>> fetchLogin(String email, String password) async {
    List<String> result = new List<String>();
    UserCredential userCredential;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential.user.email + " successfully signed in");
      print(userCredential.user.uid + 'here is the UID');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      result.add(e.code);
    }

    if (result.isEmpty) {
      result.add('success');
    }

    return result;
  }
}

class NetworkException implements Exception {}
