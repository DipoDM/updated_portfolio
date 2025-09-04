import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Professional Tech Palette
  static const brandPrimary = Color(0xFF4F46E5); // Indigo - trust, innovation
  static const brandSecondary = Color(0xFF06B6D4); // Cyan - creativity, tech
  static const brandTertiary = Color(0xFF8B5CF6); // Purple - premium, creative
  static const brandAccent = Color(0xFF10B981); // Emerald - success, growth
  
  // Neutral Palette - High contrast, professional
  static const neutral50 = Color(0xFFFAFAFA);
  static const neutral100 = Color(0xFFF5F5F5);
  static const neutral200 = Color(0xFFE5E7EB);
  static const neutral300 = Color(0xFFD1D5DB);
  static const neutral400 = Color(0xFF9CA3AF);
  static const neutral500 = Color(0xFF6B7280);
  static const neutral600 = Color(0xFF4B5563);
  static const neutral700 = Color(0xFF374151);
  static const neutral800 = Color(0xFF1F2937);
  static const neutral900 = Color(0xFF111827);
  
  // Dark Theme Palette - Deep, rich colors
  static const darkNeutral50 = Color(0xFF0F1419);
  static const darkNeutral100 = Color(0xFF1A202C);
  static const darkNeutral200 = Color(0xFF2D3748);
  static const darkNeutral300 = Color(0xFF4A5568);
  static const darkNeutral400 = Color(0xFF718096);
  static const darkNeutral500 = Color(0xFFA0AEC0);
  static const darkNeutral600 = Color(0xFFE2E8F0);
  static const darkNeutral700 = Color(0xFFF7FAFC);
  
  // Semantic Colors
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
  
  // Gradient Collections
  static const primaryGradient = [brandPrimary, brandSecondary];
  static const secondaryGradient = [brandSecondary, brandTertiary];
  static const accentGradient = [brandTertiary, brandAccent];
  static const heroGradient = [Color(0xFF667EEA), Color(0xFF764BA2)];
  static const darkHeroGradient = [Color(0xFF0B1020), Color(0xFF1A2340)];
  
  // Glass/Blur Effects
  static const glassLight = Color(0x0DFFFFFF);
  static const glassDark = Color(0x1A000000);
  
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: brandPrimary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFEEF2FF),
    onPrimaryContainer: Color(0xFF1E1B4B),
    
    secondary: brandSecondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFE0F7FA),
    onSecondaryContainer: Color(0xFF0E4B5C),
    
    tertiary: brandTertiary,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFF3E8FF),
    onTertiaryContainer: Color(0xFF4C1D95),
    
    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFEDEA),
    onErrorContainer: Color(0xFF93003A),
    
    surface: Colors.white,
    onSurface: neutral900,
    surfaceContainerHighest: neutral100,
    onSurfaceVariant: neutral600,
    
    outline: neutral300,
    outlineVariant: neutral200,
    
    shadow: Color(0x0A111827),
    scrim: Color(0x52111827),
    
    inverseSurface: neutral800,
    onInverseSurface: neutral100,
    inversePrimary: Color(0xFF8B8CF6),
  );
  
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF8B8CF6),
    onPrimary: Color(0xFF1E1B4B),
    primaryContainer: Color(0xFF3730A3),
    onPrimaryContainer: Color(0xFFEEF2FF),
    
    secondary: Color(0xFF22D3EE),
    onSecondary: Color(0xFF0E4B5C),
    secondaryContainer: Color(0xFF0891B2),
    onSecondaryContainer: Color(0xFFE0F7FA),
    
    tertiary: Color(0xFFA78BFA),
    onTertiary: Color(0xFF4C1D95),
    tertiaryContainer: Color(0xFF7C3AED),
    onTertiaryContainer: Color(0xFFF3E8FF),
    
    error: Color(0xFFF87171),
    onError: Color(0xFF93003A),
    errorContainer: Color(0xFFDC2626),
    onErrorContainer: Color(0xFFFFEDEA),
    
    surface: darkNeutral100,
    onSurface: darkNeutral700,
    surfaceContainerHighest: darkNeutral200,
    onSurfaceVariant: darkNeutral500,
    
    outline: darkNeutral300,
    outlineVariant: darkNeutral200,
    
    shadow: Color(0xCC000000),
    scrim: Color(0x52000000),
    
    inverseSurface: neutral100,
    onInverseSurface: neutral800,
    inversePrimary: brandPrimary,
  );
  
  // Utility methods for gradients and effects
  static LinearGradient getPrimaryGradient([double opacity = 1.0]) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        brandPrimary.withValues(alpha: opacity),
        brandSecondary.withValues(alpha: opacity),
      ],
    );
  }
  
  static LinearGradient getHeroGradient(bool isDark) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark ? darkHeroGradient : heroGradient,
    );
  }
  
  static BoxShadow getElevationShadow(int elevation, {bool isDark = false}) {
    final baseOpacity = isDark ? 0.3 : 0.1;
    final blurRadius = elevation * 2.0;
    final spreadRadius = elevation * 0.5;
    final offsetY = elevation * 1.0;
    
    return BoxShadow(
      color: (isDark ? Colors.black : neutral900).withValues(alpha: baseOpacity),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      offset: Offset(0, offsetY),
    );
  }
}
