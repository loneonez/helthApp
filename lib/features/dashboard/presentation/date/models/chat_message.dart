import 'package:flutter/material.dart';

// lib/models/chat_message.dart (例)
class ChatMessage {
  final String text;
  final bool isUser; // trueならユーザー、falseならAI
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}