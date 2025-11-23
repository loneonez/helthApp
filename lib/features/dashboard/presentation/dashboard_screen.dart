import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 0: AI（初期選択）
  // 1: ともだち
  int _currentIndex = 0;

  // タブボタンのウィジェットを抽出
  Widget _buildTabButton(String title, int index, double width, double height) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Colors.black : Colors.white;
    final textColor = isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // ボタンの幅を画面幅の約25%に設定
    final buttonWidth = width * 0.25;
    final buttonHeight = height * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,

      // 💡 body: SafeArea(child: Column(...)) で全ての要素をラップ
      body: SafeArea(
        child: Column(
          children: [
            // 1. タブ切り替えボタンのエリア (Container)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              color: Colors.white,
              child: Row(
                children: [
                  // 1. AI ボタン (index 0)
                  _buildTabButton('AI', 0, buttonWidth, buttonHeight),

                  // 2. ともだち ボタン (index 1)
                  _buildTabButton('ともだち', 1, buttonWidth, buttonHeight),
                ],
              ),
            ),

            // 2. 切り替えられたコンテンツを表示するエリア (Expanded)
            Expanded(
              child: Center(
                // _currentIndex の値に応じて表示するコンテンツを切り替えます
                child: _currentIndex == 0
                    ? const Text(
                        'AIチャット画面のコンテンツ（例：未読メッセージリスト）',
                        style: TextStyle(fontSize: 16),
                      )
                    : const Text(
                        'ともだち（フレンド）のノート一覧コンテンツ',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
