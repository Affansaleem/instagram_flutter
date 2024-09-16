import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User? currentUser = auth.currentUser;
    DocumentSnapshot snap =
        await fireStore.collection('users').doc(currentUser!.uid).get();
    return model.User.fromSnap(snap);
  }

  // signup user
  Future<String> signupUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      // check all fields are filled not passed empty
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty) {
        // Now register user finally
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: userName,
          bio: bio,
          followers: [],
          following: [],
        );
        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "This email is badly formatted";
      } else if (err.code == 'weak-password') {
        res = "Password should contain at least 6 characters";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
      } else {
        // when fields are empty
        res = "Please enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Sign out user
  void signOutUser() async {
    await auth.signOut();
  }
}
