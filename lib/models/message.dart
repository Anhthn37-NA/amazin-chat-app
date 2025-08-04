import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String? id;
  String? roomChatId;
  String? message;
  String? senderId;
  String? senderName;
  Timestamp? timestamp;
  List<String>? medias;
  String? type;
  Message({this.id, this.roomChatId, this.message, this.senderId, this.senderName, this.timestamp, this.medias, this.type});
  Message.fromJson(Map<String, dynamic> json){
    this.id = json["id"];
    this.roomChatId = json["room_chat_id"];
    this.message = json["message"];
    this.senderId = json["sender_id"];
    this.senderName = json["sender_name"];
    this.timestamp = json["timestamp"];
    this.medias = json["medias"] == null ? null : List<String>.from(json["medias"]);
    this.type = json["type"];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["room_chat_id"] = this.roomChatId;
    data["message"] = this.message;
    data["sender_id"] = this.senderId;
    data["sender_name"] = this.senderName;
    data["timestamp"] = this.timestamp ?? FieldValue.serverTimestamp();
    if (this.medias != null) data["medias"] = this.medias;
    data["type"] = this.type;
    return data;
  }
}