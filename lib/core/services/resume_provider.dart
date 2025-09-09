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
        end: 'Present',
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
        end: 'July 2025',
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
      // Recent Professional & Commercial Projects
      Project(
        name: 'Web Invoice Builder',
        url: 'https://github.com/DipoDM/web_invoice_builder',
        tech: ['JavaScript', 'React', 'Node.js', 'PDF Generation'],
        description: 'Modern web-based invoice generation platform with template customization.',
        highlights: [
          'Real-time invoice preview and PDF export.',
          'Template management and custom branding.',
          'Client management and payment tracking.',
          'Responsive design for desktop and mobile.',
        ],
        isPrivate: true,
      ),
      Project(
        name: 'Co-Foundr Flutter App',
        url: 'https://github.com/DipoDM/co-foundr-flutter-app',
        tech: ['Flutter', 'Dart', 'Firebase', 'Provider'],
        description: 'Cross-platform app connecting entrepreneurs and co-founders.',
        highlights: [
          'Real-time messaging and user matching.',
          'Profile creation with skill assessment.',
          'Firebase authentication and cloud storage.',
          'Modern Material 3 design system.',
        ],
        isPrivate: true,
      ),
      Project(
        name: 'Updated Portfolio',
        url: 'https://github.com/DipoDM/updated_portfolio',
        tech: ['Flutter', 'Dart', 'Responsive Web', 'Material 3'],
        description: 'Modern, responsive portfolio built with Flutter Web.',
        highlights: [
          'Adaptive design for mobile, tablet, and desktop.',
          'Custom theme system with dark/light modes.',
          'Animated components and smooth transitions.',
          'PDF resume generation and download.',
        ],
      ),
      Project(
        name: 'Mobile Tenant Screening',
        url: 'https://github.com/DipoDM/mobile_tenant_screening',
        tech: ['Flutter', 'Dart', 'REST APIs', 'Secure Storage'],
        description: 'Mobile app for property managers to conduct tenant screenings.',
        highlights: [
          'Secure document upload and verification.',
          'Integration with credit and background check APIs.',
          'Offline support for field operations.',
          'GDPR-compliant data handling.',
        ],
        isPrivate: true,
      ),
      Project(
        name: 'AI Invoice Builder',
        url: 'https://github.com/DipoDM/ai-invoice-builder',
        tech: ['TypeScript', 'Node.js', 'OpenAI', 'MongoDB'],
        description: 'AI-powered invoice generation with smart data extraction.',
        highlights: [
          'OCR and AI text extraction from receipts.',
          'Intelligent categorization and tax calculation.',
          'RESTful API with comprehensive documentation.',
          'Scalable microservices architecture.',
        ],
        isPrivate: true,
      ),

      // Established Production Apps
      Project(
        name: 'My Invoice App',
        url: 'https://github.com/DipoDM/my-invoice-app',
        tech: ['TypeScript', 'React', 'Node.js', 'MongoDB'],
        description: 'Full-stack invoice management system for small businesses.',
        highlights: [
          'Complete CRUD operations for invoices and clients.',
          'Payment tracking and automated reminders.',
          'Multi-currency support and tax calculations.',
          'Export to PDF, Excel, and CSV formats.',
        ],
      ),
      Project(
        name: 'Cofoundr',
        url: 'https://github.com/DipoDM/cofoundr',
        tech: ['Flutter', 'Dart', 'Firebase', 'Google Maps'],
        description: 'Platform connecting entrepreneurs for collaboration and networking.',
        highlights: [
          'Location-based founder discovery.',
          'In-app messaging and video calls.',
          'Startup idea sharing and feedback system.',
          'Event creation and community features.',
        ],
      ),
      Project(
        name: 'ZooNews App',
        url: 'https://github.com/DipoDM/ZooNews',
        tech: ['Flutter', 'Dart', 'Firebase', 'Push Notifications'],
        description: 'Social news app where users vote on trending articles.',
        highlights: [
          'Deployed to App Store and Google Play.',
          'Real-time voting and engagement tracking.',
          'Firebase auth, storage, and cloud functions.',
          'Comment system with moderation tools.',
        ],
        isPrivate: true,
      ),

      // Technical & Learning Projects
      Project(
        name: 'AI Caption Generator',
        url: 'https://github.com/DipoDM/ai_caption_generator',
        tech: ['C++', 'OpenCV', 'TensorFlow', 'Computer Vision'],
        description: 'AI-powered system for generating captions from images.',
        highlights: [
          'Deep learning model for image recognition.',
          'Real-time processing with C++ optimization.',
          'Integration with popular social media APIs.',
          'Support for multiple languages and contexts.',
        ],
        isPrivate: true,
      ),
      Project(
        name: 'Resume Assistant',
        url: 'https://github.com/DipoDM/resume_assist',
        tech: ['C++', 'NLP', 'Machine Learning', 'PDF Processing'],
        description: 'Intelligent resume analysis and optimization tool.',
        highlights: [
          'ATS compatibility scoring and suggestions.',
          'Keyword optimization for job descriptions.',
          'Skills gap analysis and recommendations.',
          'Export optimized resumes in multiple formats.',
        ],
        isPrivate: true,
      ),
      Project(
        name: 'Vent Social Platform',
        url: 'https://github.com/DipoDM/vent',
        tech: ['C++', 'Qt', 'SQLite', 'Networking'],
        description: 'Anonymous social platform for stress relief and mental wellness.',
        highlights: [
          'End-to-end encrypted messaging.',
          'Mood tracking and wellness features.',
          'Community support groups and forums.',
          'Cross-platform desktop application.',
        ],
        isPrivate: true,
      ),

      // iOS Development Showcase
      Project(
        name: 'UIC Clothing App',
        url: 'https://github.com/DipoDM/UIC_Clothing_App',
        tech: ['Swift', 'UIKit', 'Core Data', 'Auto Layout'],
        description: 'Modern e-commerce iOS app with elegant UI design.',
        highlights: [
          'Custom UI components and animations.',
          'Core Data integration for offline support.',
          'Advanced Auto Layout for all screen sizes.',
          'Smooth shopping cart and checkout flow.',
        ],
      ),
      Project(
        name: 'Space Image Explorer',
        url: 'https://github.com/DipoDM/SpaceImage',
        tech: ['Swift', 'SwiftUI', 'NASA API', 'Combine'],
        description: 'iOS app showcasing NASA space images with SwiftUI.',
        highlights: [
          'Integration with NASA API for daily images.',
          'Modern SwiftUI architecture and design.',
          'Image caching and offline viewing.',
          'Share functionality with custom overlays.',
        ],
      ),
      Project(
        name: 'BMI Calculator',
        url: 'https://github.com/DipoDM/BMI-Calculator-iOS13',
        tech: ['Swift', 'UIKit', 'iOS 13', 'Health Integration'],
        description: 'Health-focused BMI calculator with modern iOS design.',
        highlights: [
          'Clean, accessible interface design.',
          'Health app integration for data tracking.',
          'Multiple measurement unit support.',
          'Historical data visualization.',
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
      location: 'Honolulu, HI',
      links: [
        ContactLink(label: 'GitHub', url: 'https://github.com/DipoDM'),
      ],
    ),
  );
});
