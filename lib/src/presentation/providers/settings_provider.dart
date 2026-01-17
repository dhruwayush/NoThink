import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings {
  final bool aiProcessingMode;
  final double entitySensitivity;
  final String accentColor;

  AppSettings({
    this.aiProcessingMode = true,
    this.entitySensitivity = 75.0,
    this.accentColor = 'blue',
  });

  AppSettings copyWith({
    bool? aiProcessingMode,
    double? entitySensitivity,
    String? accentColor,
  }) {
    return AppSettings(
      aiProcessingMode: aiProcessingMode ?? this.aiProcessingMode,
      entitySensitivity: entitySensitivity ?? this.entitySensitivity,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(AppSettings());

  void toggleAiMode(bool value) {
    state = state.copyWith(aiProcessingMode: value);
  }

  void setSensitivity(double value) {
    state = state.copyWith(entitySensitivity: value);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});
