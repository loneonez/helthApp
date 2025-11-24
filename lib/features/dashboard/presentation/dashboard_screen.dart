import 'package:flutter/material.dart';
import 'package:helthapp/features/dashboard/presentation/widgets/bottom_tab.dart';
import 'package:helthapp/features/dashboard/presentation/widgets/chat_toggle_button.dart';
import 'package:helthapp/features/dashboard/presentation/widgets/ai_chat_list.dart';
import 'package:helthapp/features/dashboard/presentation/date/models/chat_model.dart';
import 'package:helthapp/features/dashboard/presentation/date/models/chat_model.dart';

// =========================================================================
// 💡 【重要】ダミーのクラス定義：あなたのプロジェクトの実際のファイル内容に置き換えてください
// =========================================================================


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Home (BottomTab)"));
}

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("List (BottomTab)"));
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Account (BottomTab)"));
}
// =========================================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 底部ナビゲーションバーの状態（0: Home, 1: List, 2: Account）
  int _bottomTabIndex = 0;

  // Homeタブ内のヘッダーチャットタブの状態（0: AI, 1: ともだち）
  int _headerChatTabIndex = 0;

  // BottomTabで切り替える画面のリスト
  final List<Widget> _bottomScreens = [
    HomeScreen(), // index 0
    ListScreen(), // index 1
    AccountScreen(), // index 2
  ];

  // --------------------------------------------------------
  // 1. BottomTabからの通知を受け取るコールバック関数
  // --------------------------------------------------------
  void _onBottomTabTapped(int index) {
    setState(() {
      _bottomTabIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final buttonWidth = width * 0.25;
    final buttonHeight = height * 0.04;

    // データの定義はここに残る (状態管理やデータフェッチの責務はStateクラスにあるため)
    final List<ChatModel> aiChats = [
      ChatModel(
        id: 'ai-buddy-1',
        name: 'バディAI',
        avatarUrl: 'assets/avatar_buddy.png',
        lastMessage: 'ゆうたくん、昨日はよく眠れたみたいだね！今日の調子は？',
        lastMessageTime: '07:00',
        unreadCount: 1,
      ),
    ];
    

    // ... (画面切り替えロジック)
    final bool isHomeScreenSelected = _bottomTabIndex == 0;
    final Widget currentBottomTabScreen = _bottomScreens[_bottomTabIndex];

    // 💡 Home 画面（インデックス0）が選択されたときに表示する専用のコンテンツ
    final Widget homeScreenContent = Column(
      children: [
        // 1. タブ切り替えボタンのエリア (ChatToggleButtonを使用)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.white,
          child: Row(
            children: [
              // AI ボタン
              ChatToggleButton(
                title: 'AI',
                isSelected: _headerChatTabIndex == 0,
                width: buttonWidth,
                height: buttonHeight,
                onTap: () {
                  setState(() {
                    _headerChatTabIndex = 0;
                  });
                },
              ),
              // ともだち ボタン
              ChatToggleButton(
                title: 'ともだち',
                isSelected: _headerChatTabIndex == 1,
                width: buttonWidth,
                height: buttonHeight,
                onTap: () {
                  setState(() {
                    _headerChatTabIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),

        // 2. その下のコンテンツエリア (残りの高さを全て使う)
        Expanded(
          child: _headerChatTabIndex == 0
              ? AiChatList(aiChats: aiChats) // ★新しいウィジェットに置き換え
              : const Center(child: Text('ともだち（フレンド）のノート一覧コンテンツ')),
        ),
      ],
    );

    // ... (Scaffoldを返すロジック)
    final Widget finalBodyContent = isHomeScreenSelected
        ? homeScreenContent
        : currentBottomTabScreen;

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomTab(
        onTabTapped: _onBottomTabTapped,
        currentIndex: _bottomTabIndex,
      ),

      body: SafeArea(child: finalBodyContent),
    );
  }
}
