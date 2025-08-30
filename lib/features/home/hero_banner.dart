import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/resume_models.dart';
import '../../core/widgets/responsive.dart';
import '../../core/widgets/chip.dart';

class HeroBanner extends StatelessWidget {
  final ResumeData resume;

  const HeroBanner({
    super.key,
    required this.resume,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: Responsive.getPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: Responsive.isMobile(context) ? 60 : 80,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            child: Text(
              resume.fullName.split(' ').map((n) => n[0]).join(),
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            resume.fullName,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            resume.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              resume.summary,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              AppChip(
                label: 'View Projects',
                icon: Icons.work,
                isSelected: true,
                onTap: () => context.go('/projects'),
              ),
              AppChip(
                label: 'Download Resume',
                icon: Icons.download,
                onTap: () => context.go('/resume'),
              ),
              AppChip(
                label: 'Contact Me',
                icon: Icons.contact_mail,
                onTap: () => context.go('/contact'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
