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
    
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Responsive.getMaxWidth(context),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Skills & Technologies',
              subtitle: 'Technologies and tools I work with',
            ),
            _buildSkillsGrid(context, resume.skills),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSkillsGrid(BuildContext context, List<String> skills) {
    final skillCategories = _categorizeSkills(skills);
    
    return Column(
      children: skillCategories.entries.map((entry) {
        return _buildSkillCategory(context, entry.key, entry.value);
      }).toList(),
    );
  }
  
  Widget _buildSkillCategory(
    BuildContext context,
    String category,
    List<String> skills,
  ) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                return AppChip(
                  label: skill,
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                );
              }).toList(),
            ),
          ],
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
}
