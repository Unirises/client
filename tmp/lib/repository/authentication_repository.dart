import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'User.dart';

class LogOutFailure implements Exception {}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<User> get user {
    return firebase_auth.FirebaseAuth.instance
        .userChanges()
        .map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  Future<void> loginWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final data = {
      'name': googleUser.displayName,
      'email': googleUser.email,
      'photo': googleUser.photoUrl,
      'type': 'client',
    };

    await FirebaseFirestore.instance
        .doc('users/${userCredential.user.uid}')
        .set(data, SetOptions(merge: true));
    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
  }

  Future<void> signUpWithEmailAndPassword({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) async {
    assert(name != null && phone != null && email != null && password != null);
    name = normaliseName(name);
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final data = {
      'name': name,
      'phone': phone,
      'email': email,
      'type': 'client',
    };

    await FirebaseFirestore.instance
        .doc('users/${userCredential.user.uid}')
        .set(data, SetOptions(merge: true));

    final user = firebase_auth.FirebaseAuth.instance.currentUser;
    await user.sendEmailVerification();
    await user.updateProfile(displayName: name);
  }

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

String normaliseName(String name) {
  final stringBuffer = StringBuffer();

  var capitalizeNext = true;
  for (final letter in name.toLowerCase().codeUnits) {
    // UTF-16: A-Z => 65-90, a-z => 97-122.
    if (capitalizeNext && letter >= 97 && letter <= 122) {
      stringBuffer.writeCharCode(letter - 32);
      capitalizeNext = false;
    } else {
      // UTF-16: 32 == space, 46 == period
      if (letter == 32 || letter == 46) capitalizeNext = true;
      stringBuffer.writeCharCode(letter);
    }
  }

  return stringBuffer.toString();
}
