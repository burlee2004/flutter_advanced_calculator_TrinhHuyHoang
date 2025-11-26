import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../models/calculator_settings.dart';
import '../models/calculator_mode.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Tràn nền lên AppBar
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1.0),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Container(
        // BACKGROUND GRADIENT
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E335A), // Tím than đậm
              Color(0xFF1C1B33), // Đen tím
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<CalculatorProvider>(
            builder: (context, calcProvider, _) {
              final settings = calcProvider.settings;

              return ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                children: [
                  _buildSectionHeader('Appearance'),
                  _buildGlassContainer([
                    _buildThemeSelector(context),
                  ]),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Calculator'),
                  _buildGlassContainer([
                    _buildDecimalPrecisionSelector(
                        context, settings, calcProvider),
                    _buildDivider(),
                    _buildAngleModeSelector(context, settings, calcProvider),
                  ]),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Feedback'),
                  _buildGlassContainer([
                    _buildSwitchTile(
                      'Haptic Feedback',
                      Icons.vibration_rounded,
                      settings.hapticFeedback,
                      (value) {
                        final newSettings =
                            _copySettings(settings, hapticFeedback: value);
                        calcProvider.updateSettings(newSettings);
                        StorageService.saveSettings(newSettings);
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Sound Effects',
                      Icons.volume_up_rounded,
                      settings.soundEffects,
                      (value) {
                        final newSettings =
                            _copySettings(settings, soundEffects: value);
                        calcProvider.updateSettings(newSettings);
                        StorageService.saveSettings(newSettings);
                      },
                    ),
                  ]),

                  const SizedBox(height: 24),

                  _buildSectionHeader('Data Management'),
                  _buildGlassContainer([
                    _buildHistorySizeSelector(context, settings, calcProvider),
                  ]),

                  const SizedBox(height: 16),
                  _buildClearHistoryButton(context),

                  const SizedBox(height: 40), // Bottom padding
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Helper để copy settings (giữ code gọn)
  CalculatorSettings _copySettings(CalculatorSettings current,
      {bool? hapticFeedback, bool? soundEffects}) {
    return CalculatorSettings(
      theme: current.theme,
      decimalPrecision: current.decimalPrecision,
      angleMode: current.angleMode,
      hapticFeedback: hapticFeedback ?? current.hapticFeedback,
      soundEffects: soundEffects ?? current.soundEffects,
      historySize: current.historySize,
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.cyanAccent, // Màu chữ neon nổi bật
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildGlassContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), // Nền kính mờ
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.white.withOpacity(0.1));
  }

  Widget _buildThemeSelector(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return _buildListTile(
          context,
          icon: Icons.palette_rounded,
          title: 'Theme',
          subtitle: _getThemeDisplayName(provider.themeMode),
          onTap: () {
            _showDarkDialog(
              context: context,
              title: 'Select Theme',
              children: [
                _buildRadioItem(context, 'Light', 'light', provider.themeMode,
                    (v) => provider.setTheme(v!)),
                _buildRadioItem(context, 'Dark', 'dark', provider.themeMode,
                    (v) => provider.setTheme(v!)),
                _buildRadioItem(context, 'System', 'system', provider.themeMode,
                    (v) => provider.setTheme(v!)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDecimalPrecisionSelector(
    BuildContext context,
    CalculatorSettings settings,
    CalculatorProvider provider,
  ) {
    return _buildListTile(
      context,
      icon: Icons.onetwothree_rounded, // Icon số
      title: 'Decimal Precision',
      subtitle: '${settings.decimalPrecision} decimal places',
      onTap: () {
        _showDarkDialog(
          context: context,
          title: 'Decimal Precision',
          children: List.generate(9, (index) {
            final precision = index + 2;
            return _buildRadioItem(context, '$precision decimal places',
                precision, settings.decimalPrecision, (value) {
              final newSettings = CalculatorSettings(
                  theme: settings.theme,
                  decimalPrecision: value!,
                  angleMode: settings.angleMode,
                  hapticFeedback: settings.hapticFeedback,
                  soundEffects: settings.soundEffects,
                  historySize: settings.historySize);
              provider.updateSettings(newSettings);
              StorageService.saveSettings(newSettings);
            });
          }),
        );
      },
    );
  }

  Widget _buildAngleModeSelector(
    BuildContext context,
    CalculatorSettings settings,
    CalculatorProvider provider,
  ) {
    return _buildListTile(
      context,
      icon: Icons.rotate_right_rounded,
      title: 'Angle Mode',
      subtitle: settings.angleMode.displayName,
      onTap: () {
        _showDarkDialog(
          context: context,
          title: 'Angle Mode',
          children: [
            _buildRadioItem(
                context,
                'Degrees (DEG)',
                AngleMode.degrees,
                settings.angleMode,
                (v) => _updateAngle(v!, settings, provider)),
            _buildRadioItem(
                context,
                'Radians (RAD)',
                AngleMode.radians,
                settings.angleMode,
                (v) => _updateAngle(v!, settings, provider)),
          ],
        );
      },
    );
  }

  void _updateAngle(AngleMode mode, CalculatorSettings settings,
      CalculatorProvider provider) {
    final newSettings = CalculatorSettings(
        theme: settings.theme,
        decimalPrecision: settings.decimalPrecision,
        angleMode: mode,
        hapticFeedback: settings.hapticFeedback,
        soundEffects: settings.soundEffects,
        historySize: settings.historySize);
    provider.updateSettings(newSettings);
    StorageService.saveSettings(newSettings);
  }

  Widget _buildHistorySizeSelector(
    BuildContext context,
    CalculatorSettings settings,
    CalculatorProvider provider,
  ) {
    return _buildListTile(
      context,
      icon: Icons.history_rounded,
      title: 'History Size',
      subtitle: '${settings.historySize} calculations',
      onTap: () {
        _showDarkDialog(
          context: context,
          title: 'History Size',
          children: [25, 50, 100].map((size) {
            return _buildRadioItem(
                context, '$size calculations', size, settings.historySize,
                (value) {
              final newSettings = CalculatorSettings(
                  theme: settings.theme,
                  decimalPrecision: settings.decimalPrecision,
                  angleMode: settings.angleMode,
                  hapticFeedback: settings.hapticFeedback,
                  soundEffects: settings.soundEffects,
                  historySize: value!);
              provider.updateSettings(newSettings);
              StorageService.saveSettings(newSettings);
              Provider.of<HistoryProvider>(context, listen: false)
                  .setMaxHistorySize(value);
            });
          }).toList(),
        );
      },
    );
  }

  // Widget chung cho các dòng settings có switch
  Widget _buildSwitchTile(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      value: value,
      activeColor: Colors.cyanAccent, // Màu switch khi bật
      activeTrackColor: Colors.cyanAccent.withOpacity(0.3),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.white10,
      onChanged: onChanged,
    );
  }

  // Widget chung cho các dòng settings có mũi tên navigation
  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded,
          size: 16, color: Colors.white30),
      onTap: onTap,
    );
  }

  Widget _buildClearHistoryButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
      ),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 16),
        onPressed: () {
          _showDarkDialog(
              context: context,
              title: 'Clear All History',
              content:
                  'Are you sure you want to clear all calculation history? This action cannot be undone.',
              isConfirmation: true,
              onConfirm: () {
                Provider.of<HistoryProvider>(context, listen: false)
                    .clearHistory();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color(0xFF2E335A),
                    content: Text('History cleared',
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              });
        },
        child: const Text(
          'Clear All History',
          style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  // --- HELPER CHO DARK DIALOG ---

  void _showDarkDialog({
    required BuildContext context,
    required String title,
    List<Widget>? children,
    String? content,
    bool isConfirmation = false,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2E335A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: content != null
            ? Text(content, style: const TextStyle(color: Colors.white70))
            : SingleChildScrollView(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: children!),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          if (isConfirmation)
            TextButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.pop(context);
              },
              child: const Text('Clear',
                  style: TextStyle(color: Colors.redAccent)),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioItem<T>(BuildContext context, String label, T value,
      T groupValue, Function(T?) onChanged) {
    return RadioListTile<T>(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      value: value,
      groupValue: groupValue,
      activeColor: Colors.cyanAccent,
      onChanged: (v) {
        onChanged(v);
        Navigator.pop(context); // Đóng dialog sau khi chọn
      },
    );
  }

  String _getThemeDisplayName(String theme) {
    switch (theme) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      default:
        return 'System';
    }
  }
}
