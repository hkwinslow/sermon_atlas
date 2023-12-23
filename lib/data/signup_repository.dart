import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupRepository {
  /// Throws [NetworkException].
  Future<List<String>> fetchSignup(String email, String password);
}

class FakeSignupRepository implements SignupRepository {
  @override
  Future<List<String>> fetchSignup(String email, String password) async {
    List<String> result = [];
    late UserCredential userCredential;

    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      print('Successfully created account for ' + email);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      result.add(e.code);
    } catch (e) {
      print(e);
      //result.add(e.code);
    }

    if (userCredential != null) {
          List<String> a = [];
          a.add('success');
          return a;

        }

        return result;
    
  }
}

class NetworkException implements Exception {}
