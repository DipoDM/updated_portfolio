import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/services/resume_provider.dart';
import 'timeline.dart';

class ExperienceScreen extends ConsumerWidget {
  const ExperienceScreen({super.key});

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
              title: 'Experience',
              subtitle: 'My professional journey and key achievements',
            ),
            ExperienceTimeline(experiences: resume.experience),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
