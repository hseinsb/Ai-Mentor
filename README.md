# AI Mentor - Relationship Guidance App

A Flutter-based mobile application that provides AI-powered relationship mentoring for singles, featuring red flag detection, compatibility analysis, and personalized guidance.

## Features

### Core Features
- **Red Flag Radar**: AI-powered analysis of relationship patterns and compatibility
- **Private Mentor Chat**: Secure conversations with AI mentor for guidance
- **Calendar & Memories**: Track important dates and relationship milestones
- **Guides Library**: 15-step relationship guidance program
- **Progress Tracking**: Monitor relationship insights and growth over time

### Authentication & Security
- Email/password authentication
- Google and Apple Sign-In integration
- End-to-end encryption for sensitive data
- Privacy-focused design with no third-party data sharing

### Subscription System
- Free tier with basic features
- Premium tiers with unlimited analysis and advanced features
- RevenueCat integration for cross-platform payments

## Tech Stack

### Frontend
- **Flutter** (Dart) - Cross-platform mobile development
- **Riverpod** - State management
- **Go Router** - Navigation
- **Firebase SDK** - Backend integration

### Backend
- **Firebase Auth** - User authentication
- **Cloud Firestore** - Database
- **Cloud Functions** - Serverless API (TypeScript)
- **Firebase Storage** - File storage
- **Firebase Messaging** - Push notifications

### AI Integration
- **OpenAI API** - LLM for relationship analysis
- **Custom scoring algorithms** - Red flag detection logic

## Project Structure

```
lib/
├── core/
│   ├── constants/     # App constants and configuration
│   ├── theme/         # App theme and styling
│   └── utils/         # Utility functions
├── data/
│   ├── models/        # Data models (Freezed)
│   ├── repositories/  # Data access layer
│   └── services/      # Firebase and API services
└── presentation/
    ├── providers/     # Riverpod providers
    ├── screens/       # App screens
    └── widgets/       # Reusable UI components

functions/
├── src/
│   ├── ai/           # AI processing functions
│   ├── admin/        # Admin utilities
│   └── utils/        # Shared utilities
└── package.json      # Cloud Functions dependencies
```

## Setup Instructions

### Prerequisites
- Flutter SDK (>=3.13.0)
- Firebase CLI
- Node.js (v18+) for Cloud Functions
- Android Studio / Xcode for platform-specific builds

### 1. Flutter Setup
```bash
# Install Flutter dependencies
flutter pub get

# Generate code for Freezed models
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 2. Firebase Configuration

#### A. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create a new project named "ai-mentor-app"
3. Enable the following services:
   - Authentication (Email/Password, Google, Apple)
   - Cloud Firestore
   - Cloud Storage
   - Cloud Functions
   - Cloud Messaging

#### B. Configure Firebase for Flutter
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in project
firebase init

# Add FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for Flutter
flutterfire configure
```

#### C. Update Configuration Files
1. Replace placeholder values in `lib/firebase_options.dart`
2. Add your actual `google-services.json` (Android)
3. Add your actual `GoogleService-Info.plist` (iOS)

### 3. Cloud Functions Setup
```bash
cd functions
npm install
npm run build
firebase deploy --only functions
```

### 4. Environment Variables
Create `functions/.env` file:
```
OPENAI_API_KEY=your_openai_api_key
STRIPE_SECRET_KEY=your_stripe_secret_key  # Optional
REVENUECAT_SECRET=your_revenuecat_secret  # Optional
```

### 5. Firestore Security Rules
Deploy the security rules:
```bash
firebase deploy --only firestore:rules
```

### 6. RevenueCat Setup (Optional)
1. Create account at [RevenueCat](https://www.revenuecat.com)
2. Configure products:
   - Monthly Basic ($9)
   - Monthly Pro ($30)
   - Yearly Basic ($60)
3. Add API keys to your app configuration

## Development

### Running the App
```bash
# Run in debug mode
flutter run

# Run with specific flavor
flutter run --flavor dev
flutter run --flavor staging
flutter run --flavor prod
```

### Code Generation
```bash
# Generate Freezed models and JSON serialization
flutter packages pub run build_runner build

# Watch for changes
flutter packages pub run build_runner watch
```

### Testing Cloud Functions Locally
```bash
cd functions
npm run serve  # Starts Firebase emulators
```

## Data Privacy & Security

### Privacy Features
- **Local Encryption**: Sensitive notes can be encrypted locally
- **Data Ownership**: Users can export or delete all their data
- **No Third-Party Sharing**: User data is never shared with external parties
- **Minimal Data Collection**: Only essential data is collected

### Security Measures
- Firestore security rules enforce user data isolation
- Firebase Auth provides secure authentication
- API keys and sensitive data are properly secured
- Regular security audits and updates

## Deployment

### App Store Deployment
1. **iOS**:
   ```bash
   flutter build ios --release
   # Use Xcode to upload to App Store Connect
   ```

2. **Android**:
   ```bash
   flutter build appbundle --release
   # Upload to Google Play Console
   ```

### Firebase Deployment
```bash
# Deploy all Firebase services
firebase deploy

# Deploy specific services
firebase deploy --only functions
firebase deploy --only firestore:rules
```

## Business Model

### Subscription Tiers
- **Free**: 3 daily AI interactions, basic features
- **Basic ($9/month)**: 10 daily interactions, calendar features
- **Pro ($30/month)**: Unlimited interactions, premium guides, PDF reports

### Revenue Streams
- Monthly/yearly subscriptions
- Premium content and guides
- Advanced analytics and reports

## Key Metrics & Analytics

### User Engagement
- Daily/Monthly Active Users
- Retention rates (D1, D7, D30)
- Feature usage analytics
- Red Flag Radar usage frequency

### Business Metrics
- Subscription conversion rates
- Customer Lifetime Value (CLV)
- Churn rates by plan
- Revenue per user

## Support & Documentation

### User Support
- In-app help system
- FAQ and knowledge base
- Email support integration
- Privacy policy and terms of service

### Developer Documentation
- API documentation for Cloud Functions
- Data model documentation
- Security best practices
- Deployment guides

## Contributing

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful commit messages
- Implement proper error handling
- Add tests for critical functionality

### Pull Request Process
1. Create feature branch from `main`
2. Implement changes with tests
3. Update documentation if needed
4. Submit PR with clear description

## License

This project is proprietary software. All rights reserved.

## Contact

For technical questions or support:
- Email: support@aimentor.app
- Documentation: [docs.aimentor.app](https://docs.aimentor.app)

---

**Note**: This is a production-ready application. Ensure all Firebase configuration files contain your actual project credentials before deployment.
