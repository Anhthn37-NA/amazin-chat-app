import 'dart:async';
import 'dart:io';

import 'package:achat/data_source/firebase_services.dart';
import 'package:achat/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../resources/Utils/utils.dart';


enum AuthStatus {none, authenticate, unauthenticate}
class FirebaseAuthController with ChangeNotifier{
  AuthStatus authStatus = AuthStatus.none;

  final FirebaseService _firebaseService = FirebaseService();
  late StreamSubscription _authStreamSubscription;

  AppUser? appUser;
  bool isLoading = false;

  FirebaseAuthController(){
    _init();
  }

  void _init() {
    _authStreamSubscription = _firebaseService.userChangeStream().listen((user) async {
      if (user != null) {
        // Lấy document user từ Firestore
        final value = await _firebaseService.getUser(user.uid);
        if (value != null) {
          // Nếu có user document
          appUser = value;
          authStatus = AuthStatus.authenticate;
        } else {
          // Nếu chưa có document user (bị xóa hoặc lần đầu)
          appUser = AppUser(
            uid: user.uid,
            email: user.email ?? '',
            displayName: user.displayName ?? 'User',
            photoUrl: user.photoURL,
          );
          // Tạo user mới trong Firestore
          await _firebaseService.createUserToDatabase(appUser!);
          authStatus = AuthStatus.authenticate;
        }
      } else {
        appUser = null;
        authStatus = AuthStatus.unauthenticate;
      }
      notifyListeners();
    });
  }



  Future signInWithEmailAndPassword({required String email, required String password}) async {
    _loading();
    await _firebaseService.signInWithEmailAndPassword(email: email, password: password);
    _unLoading();
  }

  Future signInWithGoogle() async {
    _loading();
    await _firebaseService.signInWithGoogle();
    _unLoading();
  }

  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
    File? file}) async {
    bool created = false;
    _loading();
    await _firebaseService.createAccountWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        onDone: (user) {
          appUser = user;
          authStatus = AuthStatus.authenticate;
          _unLoading();
          created = true;
        },
        onError: () {
          created = false;
        });
    return created;
  }

  Future signOut() async {
    _loading();
    await _firebaseService.signOut();
    _unLoading();
  }

  Future<bool>  updateUser({
    required String displayName,
    required File? avatar
  })async {
    _loading();
    try{
      await _firebaseService.updateUser(
          userId: appUser!.uid!,
          displayName: displayName.isEmpty? appUser!.displayName! : displayName);
      appUser = await _firebaseService.getUser(appUser!.uid!);
      Utils.showToast("Cập nhật thông tin người dùng thành công !");
      _unLoading();
      return true;
    } on FirebaseException catch (e){
      _unLoading();
      Utils.showToast(e.message ?? "");
      return false;
    }
  }

  _loading(){
    isLoading = true;
    notifyListeners();
  }

  _unLoading(){
    isLoading = false;
    notifyListeners();
  }


}