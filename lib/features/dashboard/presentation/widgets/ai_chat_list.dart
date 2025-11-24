import 'package:flutter/material.dart';
import 'package:helthapp/features/dashboard/presentation/chat_screen.dart';
import 'package:helthapp/features/dashboard/presentation/date/models/chat_model.dart';

// 💡 【重要】ダミーのクラス定義をここにもコピーするか、正しいパスに置き換えてください

// =========================================================================

class AiChatList extends StatelessWidget {
  // 親から表示するデータリストを受け取る
  final List<ChatModel> aiChats;

  const AiChatList({super.key, required this.aiChats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // スクロール可能なリストなので、このウィジェット自体にExpandedは不要
      itemCount: aiChats.length,
      itemBuilder: (context, index) {
        final chat = aiChats[index];

        // リストアイテムの構築 (内容は変更なし)
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              chat.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            chat.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            chat.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: chat.unreadCount > 0 ? Colors.black : Colors.grey.shade600,
              fontWeight: chat.unreadCount > 0
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chat.lastMessageTime,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (chat.unreadCount > 0)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${chat.unreadCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
        );
      },
    );
  }
}
