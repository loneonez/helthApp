import 'package:flutter/material.dart';

class ChatModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });
}
