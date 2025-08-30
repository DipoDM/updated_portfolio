# Oladipo Danmusa - Portfolio

A professional Flutter Web portfolio showcasing my experience as a Technical Lead and Senior Mobile Developer.

## Features

- **Responsive Design**: Optimized for mobile, tablet, and desktop
- **URL Synchronization**: Deep-linkable sections with hash routing
- **Resume Generation**: Dynamic PDF generation and static fallback
- **Easter Egg Game**: Hidden dodger game accessible via Konami code
- **Accessibility**: Screen reader support and keyboard navigation
- **Performance**: Optimized animations and reduced motion support

## Getting Started

### Prerequisites

- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)

### Installation

1. Clone the repository
2. Install dependencies:
   \`\`\`bash
   flutter pub get
   \`\`\`

3. Run the app:
   \`\`\`bash
   flutter run -d chrome
   \`\`\`

### Building for Production

\`\`\`bash
flutter build web --release
\`\`\`

## Project Structure

\`\`\`
lib/
├── core/
│   ├── theme/          # App theming and colors
│   ├── widgets/        # Reusable UI components
│   └── services/       # Data models and providers
├── features/
│   ├── home/           # Landing page and hero section
│   ├── projects/       # Project showcase
│   ├── experience/     # Professional timeline
│   ├── skills/         # Skills and technologies
│   ├── about/          # About me section
│   ├── contact/        # Contact information
│   ├── resume/         # Resume preview and download
│   └── play/           # Easter egg game
├── router/             # App routing configuration
└── utils/              # Utility functions
\`\`\`

## Key Technologies

- **Flutter Web**: Cross-platform UI framework
- **Riverpod**: State management
- **go_router**: Declarative routing with deep linking
- **PDF Generation**: Dynamic resume creation
- **Google Fonts**: Typography
- **Custom Painters**: Particle effects and game graphics

## Features in Detail

### URL Synchronization
The app updates the URL as you navigate and scroll, enabling:
- Direct links to specific sections
- Browser back/forward navigation
- Bookmarkable content

### Resume Download
Two download options:
1. **Generated PDF**: Created dynamically from data
2. **Static PDF**: Fallback file for compatibility

### Easter Egg Game
Access the hidden game by:
- Entering the Konami code: ↑↑↓↓←→←→BA
- Or long-pressing the logo (mobile)

### Accessibility
- Semantic HTML structure
- Screen reader support
- Keyboard navigation
- Reduced motion support
- High contrast ratios

## Performance Optimizations

- RepaintBoundary for custom painters
- Throttled animations (30fps)
- Conditional particle effects based on device capabilities
- Lazy loading of heavy components

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge

## License

This project is licensed under the MIT License.
