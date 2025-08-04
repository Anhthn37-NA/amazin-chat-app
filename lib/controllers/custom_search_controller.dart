import 'package:flutter/material.dart';
import '../data_source/firebase_services.dart';
import '../models/app_user.dart';


class CustomSearchController extends ChangeNotifier {
  List<AppUser> _listAllUser = [];
  List<AppUser> _listSearchUser = [];

  List<AppUser> get listSearchUser => _listSearchUser;

  List<AppUser> get listAllUser => _listAllUser;

  FirebaseService firebaseServices = FirebaseService();

  CustomSearchController(String uid) {
    _init(uid);
  }

  _init(String uid) async {
    _listAllUser = await firebaseServices.searchUser(uid);
    notifyListeners();
  }

  searchUser(String text) {
    List<AppUser> list = [];
    if (text.isNotEmpty) {
      _listAllUser.forEach((element) {
        final displayName = element.displayName!.toLowerCase();
        final email = element.email!.toLowerCase();
        final query = text.toLowerCase();
        if (displayName.contains(query) || email.contains(query)) {
          list.add(element);
        }
      });
      _listSearchUser = list;
    } else {
      _listSearchUser = [];
    }
    notifyListeners();
  }

  clearSearch() {
    _listSearchUser = [];
    notifyListeners();
  }
}