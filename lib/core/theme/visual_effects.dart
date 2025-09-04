import 'package:flutter/material.dart';
import 'colors.dart';

class VisualEffects {
  /// Creates a glassmorphism container with backdrop blur effect
  static Widget glassContainer({
    required Widget child,
    double borderRadius = 16,
    Color? backgroundColor,
    double blur = 20,
    Border? border,
    EdgeInsetsGeometry? padding,
    double opacity = 0.1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? AppColors.glassLight.withValues(alpha: opacity),
        border: border ?? Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          child: child,
        ),
      ),
    );
  }

  /// Creates a premium elevation shadow system
  static List<BoxShadow> getPremiumElevation(
    int level, {
    bool isDark = false,
    Color? shadowColor,
  }) {
    final baseColor = shadowColor ?? 
        (isDark ? Colors.black : AppColors.neutral900);
    
    switch (level) {
      case 1:
        return [
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.3 : 0.04),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ];
      case 2:
        return [
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.4 : 0.08),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.2 : 0.04),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ];
      case 3:
        return [
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.5 : 0.12),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.3 : 0.06),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ];
      case 4:
        return [
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.6 : 0.16),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.4 : 0.08),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ];
      default:
        return [
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.7 : 0.2),
            offset: const Offset(0, 12),
            blurRadius: 32,
          ),
          BoxShadow(
            color: baseColor.withValues(alpha: isDark ? 0.5 : 0.12),
            offset: const Offset(0, 6),
            blurRadius: 16,
          ),
        ];
    }
  }

  /// Creates a gradient border effect
  static Widget gradientBorder({
    required Widget child,
    required List<Color> colors,
    double width = 2,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(colors: colors),
      ),
      child: Container(
        margin: EdgeInsets.all(width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius - width),
          color: Colors.white,
        ),
        padding: padding,
        child: child,
      ),
    );
  }

  /// Creates a shimmer loading effect
  static Widget shimmer({
    required Widget child,
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                baseColor ?? Colors.grey[300]!,
                highlightColor ?? Colors.grey[100]!,
                baseColor ?? Colors.grey[300]!,
              ],
              stops: [
                0.0,
                value,
                1.0,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: child,
    );
  }

  /// Creates a floating animation effect
  static Widget floatingAnimation({
    required Widget child,
    Duration duration = const Duration(seconds: 3),
    double offset = 8.0,
    Curve curve = Curves.easeInOut,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        final animatedValue = curve.transform(value);
        final yOffset = offset * (0.5 - (animatedValue - 0.5).abs());
        
        return Transform.translate(
          offset: Offset(0, yOffset),
          child: child,
        );
      },
      child: child,
    );
  }

  /// Creates a pulse animation effect
  static Widget pulseAnimation({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
    double minScale = 0.95,
    double maxScale = 1.05,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: minScale, end: maxScale),
      duration: duration,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      onEnd: () {
        // Reverse animation would be handled by AnimationController in actual implementation
      },
      child: child,
    );
  }

  /// Creates a gradient text effect
  static Widget gradientText(
    String text, {
    required List<Color> colors,
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ).createShader(bounds),
      child: Text(
        text,
        style: style?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ) ?? const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        textAlign: textAlign,
      ),
    );
  }

  /// Creates a morphing container with smooth transitions
  static Widget morphingContainer({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    double borderRadius = 12,
    Color? color,
    List<BoxShadow>? boxShadow,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      padding: padding,
      margin: margin,
      child: child,
    );
  }

  /// Creates a premium button with gradient and glow effects
  static Widget premiumButton({
    required String text,
    required VoidCallback onPressed,
    List<Color>? gradientColors,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    double glowRadius = 8,
  }) {
    final colors = gradientColors ?? [
      AppColors.brandPrimary,
      AppColors.brandSecondary,
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(colors: colors),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.3),
            blurRadius: glowRadius,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Text(
              text,
              style: textStyle ?? const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}