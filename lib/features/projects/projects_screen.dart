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
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: Responsive.isMobile(context) ? 1.2 : 1.1,
              ),
              itemCount: resume.projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: resume.projects[index]);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
