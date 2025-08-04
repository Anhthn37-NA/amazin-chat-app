import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChat{
  String? id;
  List<String>? membersId;
  String? message;
  String? senderId;
  Timestamp? timestamp;
  RoomChat({this.id, this.membersId, this.message, this.senderId, this.timestamp});

  RoomChat.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.membersId = json["members_id"] == null
    ? null
    :List<String>.from(json["members_id"]);
    this.message = json["message"];
    this.senderId = json["sender_id"];
    this.timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    if (this.membersId != null) data["members_id"] = this.membersId;
    data["message"] = this.message;
    data["sender_id"] = this.senderId;
    data["timestamp"] = this.timestamp ?? FieldValue.serverTimestamp();
    return data;
  }
}