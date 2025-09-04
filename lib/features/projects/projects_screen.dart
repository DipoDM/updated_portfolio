import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/services/resume_provider.dart';
import 'project_card.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

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
              title: 'Projects',
              subtitle: 'A showcase of my recent work and contributions',
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = Responsive.isMobile(context);
                const spacing = 16.0;
                
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: resume.projects.asMap().entries.map((entry) {
                    final project = entry.value;
                    final cardWidth = isMobile
                        ? constraints.maxWidth
                        : (constraints.maxWidth - spacing) / 2;
                    
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: cardWidth,
                        minWidth: cardWidth,
                      ),
                      child: ProjectCard(project: project),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
