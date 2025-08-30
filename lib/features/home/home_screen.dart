import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/services/resume_models.dart';
import '../../core/widgets/responsive.dart';
import '../../core/services/resume_provider.dart';
import 'hero_banner.dart';
import 'background/particle_painter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If your provider is AsyncValue<ResumeData>, change to:
    // final asyncResume = ref.watch(resumeProvider);
    // return asyncResume.when(
    //   data: (resume) => _ScaffoldBody(resume: resume),
    //   loading: () => const Center(child: CircularProgressIndicator()),
    //   error: (_, __) => const Center(child: Text('Failed to load résumé')),
    // );
    final resume = ref.watch(resumeProvider); // assumes ResumeData directly
    return _ScaffoldBody(resume: resume);
  }
}

class _ScaffoldBody extends StatelessWidget {
  const _ScaffoldBody({required this.resume});
  final ResumeData resume;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Let the theme show through if you want:
      // backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          // ⬇️ not const anymore, so it can respond to Theme changes
          const Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: RepaintBoundary(
                child: ParticleBackground(),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Responsive.getMaxWidth(context)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        HeroBanner(resume: resume),
                        const SizedBox(height: 60),
                        _buildQuickStats(context, resume),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, ResumeData resume) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      color: theme.colorScheme.surface.withOpacity(0.92), // subtle translucency over bg
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildStatItem(context, '9+', 'Years Experience', Icons.timeline),
            _buildStatItem(context, '${resume.projects.length}+', 'Projects', Icons.work),
            _buildStatItem(context, '${resume.skills.length}+', 'Technologies', Icons.code),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 140), // helps balance layout
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
