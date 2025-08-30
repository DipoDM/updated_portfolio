import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/projects/projects_screen.dart';
import '../features/experience/experience_screen.dart';
import '../features/skills/skills_screen.dart';
import '../features/about/about_screen.dart';
import '../features/contact/contact_screen.dart';
import '../features/resume/resume_screen.dart';
import '../features/play/play_screen.dart';
import '../core/widgets/app_scaffold.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/projects',
            name: 'projects',
            builder: (context, state) => const ProjectsScreen(),
          ),
          GoRoute(
            path: '/experience',
            name: 'experience',
            builder: (context, state) => const ExperienceScreen(),
          ),
          GoRoute(
            path: '/skills',
            name: 'skills',
            builder: (context, state) => const SkillsScreen(),
          ),
          GoRoute(
            path: '/about',
            name: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: '/contact',
            name: 'contact',
            builder: (context, state) => const ContactScreen(),
          ),
          GoRoute(
            path: '/resume',
            name: 'resume',
            builder: (context, state) => const ResumeScreen(),
          ),
          GoRoute(
            path: '/play',
            name: 'play',
            builder: (context, state) => const PlayScreen(),
          ),
        ],
      ),
    ],
  );
});
