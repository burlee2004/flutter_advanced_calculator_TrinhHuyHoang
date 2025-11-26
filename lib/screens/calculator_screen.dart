import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import thêm để chỉnh màu status bar
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../widgets/display_area.dart';
import '../widgets/button_grid.dart';
import '../widgets/mode_selector.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Đặt màu status bar cho đồng bộ với thiết kế tối/sáng
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      // Cho phép body tràn lên cả phần AppBar để tạo hiệu ứng full màn hình
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'A C Trinh Huy Hoang',
          style: TextStyle(fontWeight: FontWeight.w300, letterSpacing: 1.2),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Làm AppBar trong suốt
        elevation: 0, // Bỏ bóng đổ của AppBar
        iconTheme:
            const IconThemeData(color: Colors.white), // Icon màu trắng cho nổi
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            tooltip: 'Lịch sử',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'Cài đặt',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        // TẠO MÀU NỀN GRADIENT HIỆN ĐẠI
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E335A), // Màu tím than đậm
              Color(0xFF1C1B33), // Màu đen tím
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Mode selector với padding
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ModeSelector(),
              ),

              // Display area - Cho vào Container để tạo khối riêng biệt (như màn hình LCD)
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05), // Nền mờ nhẹ
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const DisplayArea(),
                ),
              ),

              // Đường kẻ mờ phân chia màn hình và phím
              Divider(color: Colors.white.withOpacity(0.1), height: 1),

              // Button grid - flex 5
              Expanded(
                flex: 5, // Tăng không gian cho phím bấm một chút
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Consumer2<CalculatorProvider, HistoryProvider>(
                    builder: (context, calcProvider, historyProvider, _) {
                      return ButtonGrid(
                        mode: calcProvider.mode,
                        onInput: calcProvider.input,
                        onOperator: calcProvider.inputOperator,
                        onCalculate: () =>
                            calcProvider.calculate(historyProvider),
                        onClear: calcProvider.clear,
                        onClearEntry: calcProvider.clearEntry,
                        onBackspace: calcProvider.backspace,
                        onPercent: calcProvider.percent,
                        onNegate: calcProvider.negate,
                        onScientific: calcProvider.scientificFunction,
                        onMemoryAdd: calcProvider.memoryAdd,
                        onMemorySubtract: calcProvider.memorySubtract,
                        onMemoryRecall: calcProvider.memoryRecall,
                        onMemoryClear: calcProvider.memoryClear,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
