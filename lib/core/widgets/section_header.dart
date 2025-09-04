import 'package:flutter/material.dart';
import 'responsive.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    // Responsive spacing and layout
    final bottomPadding = isMobile ? 16.0 : isTablet ? 20.0 : 24.0;
    final titleSubtitleSpacing = isMobile ? 6.0 : 8.0;
    
    // Action button handling for mobile
    final shouldWrapAction = isMobile && action != null;
    
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: shouldWrapAction
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSubtitle(context, theme, isMobile, titleSubtitleSpacing),
                SizedBox(height: isMobile ? 12 : 16),
                action!,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _buildTitleSubtitle(context, theme, isMobile, titleSubtitleSpacing),
                ),
                if (action != null && !isMobile) ...[
                  const SizedBox(width: 16),
                  action!,
                ],
              ],
            ),
    );
  }
  
  Widget _buildTitleSubtitle(BuildContext context, ThemeData theme, bool isMobile, double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: isMobile
              ? theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  fontSize: 24,
                )
              : theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: spacing),
          Text(
            subtitle!,
            style: isMobile
                ? theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                : theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
          ),
        ],
      ],
    );
  }
}
