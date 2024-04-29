import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/error_model.dart';
import '../../config/result_class.dart';
import '../../util/prefrences_helper.dart';
import '../models/user_model.dart';

class AuthDataSource {
  Future<ResponseState<UserModel>> signUp({
    required firstName,
    required lastName,
    required email,
    required password,
    required accountType,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'firstName': firstName,
        'email': email,
        'lastName': lastName,
        'accountType': accountType,
      });

      final userData = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName,
        email: email,
        lastName: lastName,
        accountType: accountType,
      );
      await PrefHelper.saveUsersInfo(userData);
      return ResponseState.success(userData);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<UserModel>> signIn(
      {required email, required password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel? userData;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get()
          .then((value) {
        userData = UserModel.fromMap(value.data()!);
      });
      await PrefHelper.saveUsersInfo(userData!);
      return ResponseState.success(userData!);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("userInfo");
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> resetPassword({required email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }
}
