import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/foundation.dart'; // kIsWeb を使うため
import 'package:helthapp/features/dashboard/presentation/date/models/chat_message.dart';

// ⚠️ APIキーを安全に扱うための処理（ここでは仮の定数として扱います）
// 【重要】本番環境では、外部ファイルや環境変数を使ってください。
// ここに新しいキーを貼り付けます（安全にローカルで作業してください）
const String _apiKey = 'AIzaSyDlbXQw_HZD3OIMtYRHdX0-hNzl02vZeGg';
const String _modelName = 'gemini-2.5-flash';

// =========================================================================

// 遷移先の画面
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // メッセージのリスト
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late final GenerativeModel _model; // Geminiモデルのインスタンス

  @override
  void initState() {
    super.initState();
    // 画面初期化時にGeminiモデルを準備
    if (_apiKey.isEmpty) {
      // kIsWeb はWeb/モバイル判定に使えるが、ここではAPIキーの有無の確認を簡略化
      print("エラー: Gemini APIキーが設定されていません。");
      return;
    }
    _model = GenerativeModel(model: _modelName, apiKey: _apiKey);
  }

  // -------------------------------------------------------------------
  // 3. ユーザーの入力を処理し、AIに送信する
  // -------------------------------------------------------------------
  void _handleSubmitted(String text) async {
    // 1. ユーザーメッセージをリストに追加
    setState(() {
      _messages.insert(
        0,
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
    });
    _textController.clear(); // 入力欄をクリア

    // 2. AIからの応答を待つ間、ローディングメッセージを表示
    final loadingMessage = ChatMessage(
      text: "考え中...",
      isUser: false,
      timestamp: DateTime.now(),
    );
    setState(() {
      _messages.insert(0, loadingMessage);
    });

    try {
      // 3. Gemini APIを呼び出し
      final response = await _model.generateContent([Content.text(text)]);
      final aiReply = response.text ?? '応答がありませんでした。';

      // 4. ローディングメッセージを削除
      setState(() {
        _messages.remove(loadingMessage);
      });

      // 5. AIの応答をリストに追加
      setState(() {
        _messages.insert(
          0,
          ChatMessage(text: aiReply, isUser: false, timestamp: DateTime.now()),
        );
      });
    } catch (e) {
      print("Gemini APIエラー: $e");
      // 4. ローディングメッセージを削除し、エラーメッセージに置き換える
      setState(() {
        _messages.remove(loadingMessage);
        _messages.insert(
          0,
          ChatMessage(
            text: '通信エラーが発生しました。',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('バディAIとチャット'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // メッセージ表示エリア (ListView)
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true, // 最新メッセージが下に来るように反転
                itemBuilder: (_, int index) =>
                    _buildMessageBubble(_messages[index]),
                itemCount: _messages.length,
              ),
            ),
            const Divider(height: 1.0),
            // 入力エリア
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // 4. メッセージバブル（吹き出し）ウィジェットの構築
  // -------------------------------------------------------------------
  Widget _buildMessageBubble(ChatMessage message) {
    // ユーザーとAIで吹き出しのレイアウトを変更
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isUser) // AIの場合、左側にアバター
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(child: Text('AI')),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Colors.blue.shade100
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(message.text),
            ),
          ),
          if (message.isUser) // ユーザーの場合、右側にスペースを空ける
            const SizedBox(width: 40),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 5. テキスト入力ウィジェットの構築
  // -------------------------------------------------------------------
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted, // 入力完了で送信
                decoration: const InputDecoration.collapsed(
                  hintText: "メッセージを入力",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                // ボタンタップで _handleSubmitted を呼び出す
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
