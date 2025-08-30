// lib/core/services/resume_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'resume_models.dart';

final resumeProvider = Provider<ResumeData>((ref) {
  return const ResumeData(
    fullName: 'Oladipo Danmusa',
    title: 'Technical Lead & Senior Mobile Engineer (Flutter/iOS | Node.js, Python)',
    summary:
        'Technical Lead and Senior Mobile Engineer with 9+ years across Flutter and iOS, with Node.js and Python on the backend. At Visa and Roland I delivered production apps and reusable component libraries, secure payment flows, and Canva-integrated experiences. Strong on API design and integration (REST/GraphQL, JWT), state management (Provider, Riverpod), and cloud-backed systems (Firebase, Azure). I mentor teams, drive design systems and code quality, and turn ambiguous requirements into fast, reliable products on iOS, Android, and the web.',
    skills: [
      // Languages
      'Dart', 'Swift', 'Python', 'JavaScript',
      // Frameworks & Platforms
      'Flutter', 'SwiftUI', 'UIKit', 'Node.js', 'Firebase', 'Azure Functions',
      // Patterns & State
      'MVVM', 'MVC', 'Provider', 'Riverpod',
      // APIs & Data
      'REST', 'GraphQL', 'JWT', 'MongoDB', 'Realm',
      // Tooling
      'Git', 'GitHub', 'Jira', 'Figma', 'Xcode',
      // Domains
      'iOS', 'Android', 'Web (Responsive)',
    ],
    experience: [
      Experience(
        company: 'Visa',
        role: 'Design Engineer — Flutter',
        start: 'April 2022',
        end: 'August 2025',
        highlights: [
          'Built reusable, adaptive UI components and libraries in Flutter and Swift for internal/external teams.',
          'Delivered MVPs and contributed to flagship apps (e.g., Visa Olympic) with secure payment features.',
          'Led code reviews, pair programming, and mentorship to raise code quality and velocity.',
          'Integrated REST/GraphQL APIs with secure sessions (JWT).',
          'Applied Provider/Riverpod architectures for maintainable scale.',
          'Collaborated across product, design, and backend for high-quality delivery.',
        ],
      ),
      Experience(
        company: 'Roland DGA',
        role: 'Mobile Application Lead (Flutter/Node.js/UI/UX) — Remote, Contract',
        start: 'November 2022',
        end: 'September 2025',
        highlights: [
          'Owned architecture/design and delivery of cross-platform apps in Flutter.',
          'Defined scalable design systems and consistent branding.',
          'Built Node.js + Azure backends and serverless functions for real-time features.',
          'Launched Canva-integrated applications and rebuilt a responsive marketing site.',
          'Integrated international payments for seamless global transactions.',
          'Handled end-to-end store releases (App Store, Google Play).',
          'Mentored engineers; drove agile practices and high UX quality.',
        ],
      ),
      Experience(
        company: 'Lexipol',
        role: 'Mobile Developer — Flutter',
        start: 'October 2021',
        end: 'April 2022',
        highlights: [
          'Rebuilt the mobile app with the latest Flutter stack for iOS/Android.',
          'Improved data flow and performance with backend collaboration.',
          'Refactored legacy code; implemented offline support.',
          'Used Firebase for auth and real-time updates.',
        ],
      ),
      Experience(
        company: 'ShowUp',
        role: 'Mobile Developer — Flutter (Project)',
        start: 'August 2021',
        end: 'April 2022',
        highlights: [
          'Built real-time location features, chat, and QR workflows.',
          'Implemented Firebase auth, storage, and notifications.',
          'Delivered role-based UX for Driver, Customer, and Seller.',
        ],
      ),
      Experience(
        company: 'Orderlivery',
        role: 'Mobile Developer — Flutter',
        start: 'April 2021',
        end: 'October 2021',
        highlights: [
          'Shipped cross-platform app (App Store/Play) with PWA companion.',
          'MongoDB backend; Firebase; Google Maps real-time tracking.',
          'Built a web dashboard for operations visibility.',
        ],
      ),
      Experience(
        company: 'Freelance',
        role: 'Mobile Application Developer (Flutter)',
        start: 'March 2020',
        end: 'April 2022',
        highlights: [
          'ZooNews: social news app deployed to App Store and Google Play.',
          'Delivered modern features: realtime updates, uploads, comments, blocking.',
          'Worked closely with clients and designers; frequent collaborative coding.',
        ],
      ),
      Experience(
        company: 'Petroleum Marketers Equipment Company',
        role: 'IT Coordinator — Oklahoma City, OK',
        start: 'February 2018',
        end: 'February 2020',
        highlights: [
          'Built and automated e-commerce and inventory workflows.',
          'Wrote Python scrapers for data collection; introduced Microsoft Teams and Smartsheet.',
          'Migrated field techs to tablet-based tools; ran trainings and remote support.',
        ],
      ),
    ],
    projects: [
      Project(
        name: 'ZooNews App',
        url: 'https://github.com/DipoDM', // repo hub
        tech: ['Flutter', 'Dart', 'Firebase'],
        description: 'Social news app where users vote top articles.',
        highlights: [
          'Deployed to App Store and Google Play.',
          'Articles remain on home for 30h based on engagement.',
          'Firebase auth, storage, realtime updates.',
          'Sharing, image uploads, comments, user blocking.',
        ],
      ),
      Project(
        name: 'ShowUp App',
        url: 'https://github.com/DipoDM',
        tech: ['Flutter', 'Dart', 'Firebase', 'Google Maps', 'Notifications'],
        description: 'Location-based service with real-time tracking.',
        highlights: [
          'Live location and in-app messaging.',
          'Google Maps integration and role-based UX.',
          'Payment gateway integration; push notifications.',
        ],
      ),
      Project(
        name: 'Orderlivery',
        url: 'https://github.com/DipoDM',
        tech: ['Flutter', 'MongoDB', 'Firebase', 'Google Maps', 'PWA'],
        description: 'Food delivery platform with PWA and ops dashboard.',
        highlights: [
          'Cross-platform mobile apps + PWA.',
          'Real-time driver tracking and order history.',
          'Swagger documented APIs for efficient backend integration.',
        ],
      ),
      Project(
        name: 'SwiftUI Samples',
        url: 'https://github.com/DipoDM',
        tech: ['SwiftUI', 'iOS'],
        description: 'HackerNews, Random Advice, and UI demos.',
        highlights: [
          'API/JSON parsing, clean UI layers.',
        ],
      ),
    ],
    education: [
      Education(
        school: 'University of Central Oklahoma',
        degree: 'BBA, Marketing',
        year: 'December 2018',
      ),
      Education(
        school: 'Covenant University',
        degree: 'BSc, Computer Science',
        year: 'September 2014',
      ),
    ],
    contact: Contact(
      email: 'danmusad@gmail.com',
      phone: '(405) 888-3324',
      location: 'Austin, TX',
      links: [
        ContactLink(label: 'GitHub', url: 'https://github.com/DipoDM'),
      ],
    ),
  );
});
