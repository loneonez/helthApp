// lib/main.dart

import 'package:flutter/material.dart';
import 'package:helthapp/features/dashboard/presentation/chat_screen.dart';
import 'package:helthapp/features/dashboard/presentation/dashboard_screen.dart';
import 'package:helthapp/screens/splash_screen.dart';

// ----------------------------------------
// 仮のホーム画面 (この画面へ遷移します)
// ----------------------------------------

// ----------------------------------------
// アプリのエントリーポイント
// ----------------------------------------
void main() {
  // Flutterウィジェットのバインディングを初期化（必須）
  WidgetsFlutterBinding.ensureInitialized(); //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'helthapp',
      // デフォルトのテーマカラーなど
      theme: ThemeData(primarySwatch: Colors.blue),
      // 起動時にまずこの画面を表示する
      home: SplashScreen(),
    );
  }
}

// ----------------------------------------
// スプラッシュスクリーンウィジェット（待機と遷移を担当）
// ----------------------------------------
class SimpleSplashScreen extends StatefulWidget {
  const SimpleSplashScreen({super.key});

  @override
  State<SimpleSplashScreen> createState() => _SimpleSplashScreenState();
}

class _SimpleSplashScreenState extends State<SimpleSplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3秒後に遷移する処理を実行
    _navigateToHome();
  }

  _navigateToHome() async {
    // 💡 待機時間（3秒）を設定
    await Future.delayed(const Duration(seconds: 3));

    // 遷移処理: 現在の画面を置き換える（戻れないようにする）
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ネイティブスプラッシュからスムーズに移行するため、
    // ここではネイティブで設定した背景色（#FFFFFF）と同じ色のScaffoldを表示します。
    // ネイティブのアイコンが消えるまでの間、画面のチラつきを防ぎます。
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Center(child: Text('サンプル'))),
    );
  }
}
