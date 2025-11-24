import 'package:flutter/material.dart';

// ヘッダーのAI/ともだち切り替えボタン
class ChatToggleButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final double width;
  final double height;
  final VoidCallback onTap; // タップされたときに実行する関数を受け取る

  const ChatToggleButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.width,
    required this.height,
    required this.onTap, // 必須の引数として追加
  });

  @override
  Widget build(BuildContext context) {
    // isSelected の状態に基づいて色を決定
    final color = isSelected ? Colors.black : Colors.white;
    final textColor = isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap, // 親から渡されたタップ処理を実行
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}