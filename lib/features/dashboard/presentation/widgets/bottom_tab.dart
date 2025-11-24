import 'package:flutter/material.dart';

// StatelessWidget に変更！
class BottomTab extends StatelessWidget {
  final Function(int) onTabTapped; 
  final int currentIndex;

  BottomTab({
    super.key,
    required this.onTabTapped,
    required this.currentIndex,
  });

  // タブのデータはここに残してOK
  final List<Map<String, dynamic>> _Tab = [
    {'icon': Icons.home_filled, 'label': 'Home'},
    {'icon': Icons.list_alt, 'label': 'List'},
    {'icon': Icons.account_circle, 'label': 'Account'},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ..._Tab.map((item) {
            int index = _Tab.indexOf(item);
            
            // 選択状態の判定に親からもらった currentIndex を使う！
            final isSelected = index == currentIndex; 
            
            return Expanded(
              child: InkWell(
                // タップされたら、親から渡されたコールバック関数を実行！
                onTap: () => onTabTapped(index), 
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        // 色の判定に親からもらった currentIndex を使う！
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}