import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final Timestamp? time;
  final String message;
  final String image;
  final String uid;

  Message({
    required this.time,
    required this.message,
    required this.image,
    required this.uid,
  });
}
