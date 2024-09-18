import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/cashe_helper.dart';
import '../../models/user_model.dart';
import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  IconData passwordIcon = Icons.remove_red_eye_outlined;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (!userCredential.user!.emailVerified) {
        emit(LoginEmailNotVerified());
      } else {
        String userId = userCredential.user!.uid;
        CacheHelper.prefs?.setString('userId', userId);
        await getUserData(userId);
        emit(LoginSuccess());
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }


  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    passwordIcon = isPasswordVisible
        ? Icons.remove_red_eye_outlined
        : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityChanged());
  }

  Future<void> getUserData(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot userSnapshot = await users.doc(userId).get();
    UserDataModel userModel =
        UserDataModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
    // CacheHelper.addUserDataToPrefs(userModel: userModel);
  }

  void sendEmailVerification() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    emit(EmailVerificationSent());
  }

  String? validInput(String value, int minLength, int maxLength, String type) {
    if (value.isEmpty) {
      return 'This field is required';
    }

    if (value.length < minLength) {
      return 'The input is too short. Minimum $minLength characters';
    }

    if (value.length > maxLength) {
      return 'The input is too long. Maximum $maxLength characters';
    }

    if (type == 'email' &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }

    if (type == 'password' && value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

}
