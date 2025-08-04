import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static showPickImageModelBottomSheet(
    BuildContext context, {
    required Function(File) onPickImage,
  }) {
    ImagePicker imagePicker = ImagePicker();
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 120,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            ListTile(
              title: Text("From camera"),
              leading: Icon(Icons.camera_alt),
              onTap: () async {
                await imagePicker.pickImage(source: ImageSource.camera).then((
                  value,
                ) {
                  if (value != null) {
                    onPickImage(File(value.path));
                  }
                });
              },
            ),
            ListTile(
              title: Text("From gallery"),
              leading: Icon(Icons.image),
              onTap: () async {
                await imagePicker.pickImage(source: ImageSource.gallery).then((
                  value,
                ) {
                  if (value != null) {
                    onPickImage(File(value.path));
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  static String nameInit(String? name) {
    if (name == null || name.trim().isEmpty) {
      return ""; // Trả về chuỗi rỗng nếu name null hoặc chỉ có khoảng trắng
    }

    List<String> nameSplit = name.trim().split(RegExp(r"\s+")); // Tách theo khoảng trắng (1 hoặc nhiều)

    String firstName = "";
    String lastName = "";

    if (nameSplit.length >= 2) {
      if (nameSplit[0].isNotEmpty) {
        firstName = nameSplit[0][0];
      }
      if (nameSplit[1].isNotEmpty) {
        lastName = nameSplit[1][0];
      }
    } else if (nameSplit.length == 1 && nameSplit[0].isNotEmpty) {
      firstName = nameSplit[0][0];
    }

    return firstName + lastName;
  }


  static String timeStamp(Timestamp t) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final duration = now - t.millisecondsSinceEpoch;
    if (duration <= 60000) {
      return "Just now";
    } else {
      final minute = (duration / 60000).floor();
      if (minute < 60) {
        return "$minute min ago";
      } else if (minute >= 60 && minute < 60 * 24) {
        return "${(minute / 60).floor()}h ago";
      } else {
        final date = DateTime.fromMillisecondsSinceEpoch(
          t.millisecondsSinceEpoch,
        );
        return "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(2, "0")}";
      }
    }
  }

  static String userName (String email) {
    String e = email;
    if (email.isNotEmpty) {
      List<String> l = e.split("@");
      return "@${l[0]}";
    } else {
      return "";
    }
  }

}
