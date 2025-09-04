import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/chip.dart';
import '../../core/services/resume_provider.dart';

class SkillsScreen extends ConsumerWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resume = ref.watch(resumeProvider);
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Responsive.getMaxWidth(context),
        ),
        padding: Responsive.railPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Responsive.isMobile(context) ? 24 : 32),
            const SectionHeader(
              title: 'Skills & Technologies',
              subtitle: 'Technologies and tools I work with',
            ),
            _buildSkillsShowcase(context, resume.skills),
            SizedBox(height: Responsive.isMobile(context) ? 32 : 48),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSkillsShowcase(BuildContext context, List<String> skills) {
    final skillCategories = _categorizeSkills(skills);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    return Column(
      children: skillCategories.entries.map((entry) {
        return _buildModernSkillCategory(context, entry.key, entry.value);
      }).toList(),
    );
  }
  
  Widget _buildModernSkillCategory(
    BuildContext context,
    String category,
    List<String> skills,
  ) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final categoryIcon = _getCategoryIcon(category);
    final gradientColors = _getCategoryGradient(theme, category);
    
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 20 : 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
          stops: const [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
          color: theme.colorScheme.surface.withOpacity(0.95),
        ),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isMobile ? 10 : 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                  ),
                  child: Icon(
                    categoryIcon,
                    size: isMobile ? 20 : 24,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                          fontSize: isMobile ? 18 : 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${skills.length} skill${skills.length == 1 ? '' : 's'}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: isMobile ? 12 : 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 16 : 20),
            Wrap(
              spacing: isMobile ? 8 : 10,
              runSpacing: isMobile ? 8 : 10,
              children: skills.map((skill) {
                return _buildEnhancedSkillChip(context, skill, category);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedSkillChip(BuildContext context, String skill, String category) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.08),
            theme.colorScheme.primary.withOpacity(0.12),
          ],
        ),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 18),
        child: InkWell(
          borderRadius: BorderRadius.circular(isMobile ? 16 : 18),
          onTap: () {
            // Add potential skill details or portfolio filtering
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 10,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getSkillIcon(skill),
                  size: isMobile ? 14 : 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  skill,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Map<String, List<String>> _categorizeSkills(List<String> skills) {
    final categories = <String, List<String>>{
      'Languages': [],
      'Frameworks & Libraries': [],
      'Tools & Platforms': [],
      'Concepts & Practices': [],
    };
    
    final languageKeywords = ['Dart', 'Swift', 'Python', 'JavaScript'];
    final frameworkKeywords = ['Flutter', 'SwiftUI', 'Node.js', 'Firebase', 'UIKit'];
    final toolKeywords = ['Xcode', 'Git', 'GitHub', 'Jira', 'Figma', 'Azure'];
    final conceptKeywords = ['MVVM', 'MVC', 'Object-Oriented Programming', 'SDLC'];
    
    for (final skill in skills) {
      if (languageKeywords.any((keyword) => skill.contains(keyword))) {
        categories['Languages']!.add(skill);
      } else if (frameworkKeywords.any((keyword) => skill.contains(keyword))) {
        categories['Frameworks & Libraries']!.add(skill);
      } else if (toolKeywords.any((keyword) => skill.contains(keyword))) {
        categories['Tools & Platforms']!.add(skill);
      } else {
        categories['Concepts & Practices']!.add(skill);
      }
    }
    
    // Remove empty categories
    categories.removeWhere((key, value) => value.isEmpty);
    
    return categories;
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Languages':
        return Icons.code;
      case 'Frameworks & Libraries':
        return Icons.widgets;
      case 'Tools & Platforms':
        return Icons.build;
      case 'Concepts & Practices':
        return Icons.psychology;
      default:
        return Icons.star;
    }
  }

  List<Color> _getCategoryGradient(ThemeData theme, String category) {
    final primary = theme.colorScheme.primary;
    final surface = theme.colorScheme.surface;
    
    switch (category) {
      case 'Languages':
        return [
          primary.withValues(alpha: 0.15),
          primary.withValues(alpha: 0.05),
        ];
      case 'Frameworks & Libraries':
        return [
          theme.colorScheme.secondary.withValues(alpha: 0.15),
          theme.colorScheme.secondary.withValues(alpha: 0.05),
        ];
      case 'Tools & Platforms':
        return [
          theme.colorScheme.tertiary.withValues(alpha: 0.15),
          theme.colorScheme.tertiary.withValues(alpha: 0.05),
        ];
      case 'Concepts & Practices':
        return [
          primary.withValues(alpha: 0.12),
          surface.withValues(alpha: 0.8),
        ];
      default:
        return [
          primary.withValues(alpha: 0.1),
          surface.withValues(alpha: 0.9),
        ];
    }
  }

  IconData _getSkillIcon(String skill) {
    final skillLower = skill.toLowerCase();
    
    if (skillLower.contains('dart') || skillLower.contains('flutter')) {
      return Icons.flutter_dash;
    } else if (skillLower.contains('swift') || skillLower.contains('ios')) {
      return Icons.phone_iphone;
    } else if (skillLower.contains('python')) {
      return Icons.code;
    } else if (skillLower.contains('javascript') || skillLower.contains('js')) {
      return Icons.javascript;
    } else if (skillLower.contains('git')) {
      return Icons.source;
    } else if (skillLower.contains('firebase')) {
      return Icons.cloud;
    } else if (skillLower.contains('node')) {
      return Icons.dns;
    } else if (skillLower.contains('xcode') || skillLower.contains('android studio')) {
      return Icons.developer_mode;
    } else if (skillLower.contains('figma') || skillLower.contains('design')) {
      return Icons.design_services;
    } else if (skillLower.contains('azure') || skillLower.contains('aws')) {
      return Icons.cloud_queue;
    } else if (skillLower.contains('mvvm') || skillLower.contains('mvc')) {
      return Icons.architecture;
    } else if (skillLower.contains('test')) {
      return Icons.bug_report;
    } else if (skillLower.contains('object-oriented') || skillLower.contains('oop')) {
      return Icons.category;
    } else {
      return Icons.star_border;
    }
  }
}
