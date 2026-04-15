import 'package:flutter/material.dart';

@immutable
class AppUiTheme extends ThemeExtension<AppUiTheme> {
  final Color appBg;
  final Color surface;
  final Color primary;
  final Color accent;
  final Color mutedText;
  final Color mutedIcon;
  final Color chipBg;
  final Color chipSelectedBg;
  final Color chipSelectedText;
  final Color border;
  final Color paidBg;
  final Color freeBg;
  final Color paidText;
  final Color freeText;

  final double sectionTitleSize;
  final double cardTitleSize;
  final double cardMetaSize;
  final double cardRadius;
  final double chipRadius;

  final double compactCardWidth;
  final double compactImageWidth;
  final double compactImageHeight;
  final double recommendationImageHeight;

  const AppUiTheme({
    required this.appBg,
    required this.surface,
    required this.primary,
    required this.accent,
    required this.mutedText,
    required this.mutedIcon,
    required this.chipBg,
    required this.chipSelectedBg,
    required this.chipSelectedText,
    required this.border,
    required this.paidBg,
    required this.freeBg,
    required this.paidText,
    required this.freeText,
    required this.sectionTitleSize,
    required this.cardTitleSize,
    required this.cardMetaSize,
    required this.cardRadius,
    required this.chipRadius,
    required this.compactCardWidth,
    required this.compactImageWidth,
    required this.compactImageHeight,
    required this.recommendationImageHeight,
  });

  @override
  AppUiTheme copyWith({
    Color? appBg,
    Color? surface,
    Color? primary,
    Color? accent,
    Color? mutedText,
    Color? mutedIcon,
    Color? chipBg,
    Color? chipSelectedBg,
    Color? chipSelectedText,
    Color? border,
    Color? paidBg,
    Color? freeBg,
    Color? paidText,
    Color? freeText,
    double? sectionTitleSize,
    double? cardTitleSize,
    double? cardMetaSize,
    double? cardRadius,
    double? chipRadius,
    double? compactCardWidth,
    double? compactImageWidth,
    double? compactImageHeight,
    double? recommendationImageHeight,
  }) {
    return AppUiTheme(
      appBg: appBg ?? this.appBg,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      mutedText: mutedText ?? this.mutedText,
      mutedIcon: mutedIcon ?? this.mutedIcon,
      chipBg: chipBg ?? this.chipBg,
      chipSelectedBg: chipSelectedBg ?? this.chipSelectedBg,
      chipSelectedText: chipSelectedText ?? this.chipSelectedText,
      border: border ?? this.border,
      paidBg: paidBg ?? this.paidBg,
      freeBg: freeBg ?? this.freeBg,
      paidText: paidText ?? this.paidText,
      freeText: freeText ?? this.freeText,
      sectionTitleSize: sectionTitleSize ?? this.sectionTitleSize,
      cardTitleSize: cardTitleSize ?? this.cardTitleSize,
      cardMetaSize: cardMetaSize ?? this.cardMetaSize,
      cardRadius: cardRadius ?? this.cardRadius,
      chipRadius: chipRadius ?? this.chipRadius,
      compactCardWidth: compactCardWidth ?? this.compactCardWidth,
      compactImageWidth: compactImageWidth ?? this.compactImageWidth,
      compactImageHeight: compactImageHeight ?? this.compactImageHeight,
      recommendationImageHeight:
          recommendationImageHeight ?? this.recommendationImageHeight,
    );
  }

  @override
  AppUiTheme lerp(covariant ThemeExtension<AppUiTheme>? other, double t) {
    return this;
  }
}

class AppTheme {
  static const ui = AppUiTheme(
    appBg: Colors.white,
    surface: Colors.white,
    primary: Color(0xFF2F33F9),
    accent: Color(0xFFFF6A4A),
    mutedText: Color(0xFF8E929A),
    mutedIcon: Color(0xFF8E929A),
    chipBg: Color(0xFFF2F3F7),
    chipSelectedBg: Color(0xFF2F33F9),
    chipSelectedText: Colors.white,
    border: Color(0xFFDCE5FF),
    paidBg: Color(0xFFE8ECFF),
    freeBg: Color(0xFFE6F8EA),
    paidText: Color(0xFF2F33F9),
    freeText: Color(0xFF1E9C51),
    sectionTitleSize: 24,
    cardTitleSize: 12,
    cardMetaSize: 9,
    cardRadius: 12,
    chipRadius: 16,
    compactCardWidth: 167,
    compactImageWidth: 167,
    compactImageHeight: 132,
    recommendationImageHeight: 156,
  );

  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: ui.appBg,
    fontFamily: 'FindSansPro',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: ui.primary),
    extensions: const <ThemeExtension<dynamic>>[ui],
  );
}
