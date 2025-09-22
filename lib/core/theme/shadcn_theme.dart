import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ShadcnTheme {
  static const _primaryColor = Color(0xFF09090b);
  static const _backgroundColor = Color(0xFFffffff);
  static const _cardColor = Color(0xFFffffff);
  static const _mutedColor = Color(0xFFf1f5f9);
  static const _borderColor = Color(0xFFe2e8f0);
  
  // ShadCN Color Scheme
  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
    primary: _primaryColor,
    secondary: const Color(0xFF64748b),
    surface: _backgroundColor,
    background: _backgroundColor,
    error: const Color(0xFFef4444),
  );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.dark,
    primary: const Color(0xFFfafafa),
    secondary: const Color(0xFF94a3b8),
    surface: const Color(0xFF020817),
    background: const Color(0xFF020817),
    error: const Color(0xFFef4444),
  );

  // ShadCN Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: GoogleFonts.interTextTheme(),
    ).copyWith(
      extensions: [
        ShadThemeData(
          colorScheme: const ShadColorScheme.light(
            primary: _primaryColor,
            card: _cardColor,
            popover: _cardColor,
            muted: _mutedColor,
            border: _borderColor,
            input: _borderColor,
          ),
          radius: 8.0,
          textTheme: ShadTextTheme(
            family: GoogleFonts.inter().fontFamily!,
            package: GoogleFonts.inter().fontFamily,
          ),
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: GoogleFonts.interTextTheme(darkColorScheme),
    ).copyWith(
      extensions: [
        ShadThemeData(
          colorScheme: const ShadColorScheme.dark(
            primary: Color(0xFFfafafa),
            card: Color(0xFF020817),
            popover: Color(0xFF020817),
            muted: Color(0xFF0f172a),
            border: Color(0xFF1e293b),
            input: Color(0xFF1e293b),
          ),
          radius: 8.0,
          textTheme: ShadTextTheme(
            family: GoogleFonts.inter().fontFamily!,
            package: GoogleFonts.inter().fontFamily,
          ),
        ),
      ],
    );
  }

  // ShadCN Colors for Components
  static const Color primary = _primaryColor;
  static const Color secondary = Color(0xFF64748b);
  static const Color muted = _mutedColor;
  static const Color accent = Color(0xFF3b82f6);
  static const Color destructive = Color(0xFFef4444);
  static const Color border = _borderColor;
  
  // Custom gradients for dashboard cards
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3b82f6), Color(0xFF1d4ed8)],
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10b981), Color(0xFF059669)],
  );
  
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFf59e0b), Color(0xFFd97706)],
  );
  
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFef4444), Color(0xFFdc2626)],
  );
}