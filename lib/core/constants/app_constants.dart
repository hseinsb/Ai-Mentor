class AppConstants {
  static const String appName = 'AI Mentor';
  static const String appVersion = '1.0.0';
  
  // Collection names
  static const String usersCollection = 'users';
  static const String profilesCollection = 'profiles';
  static const String notesCollection = 'notes';
  static const String messagesCollection = 'messages';
  static const String analyticsCollection = 'analytics';
  static const String memoriesCollection = 'memories';
  static const String guidesCollection = 'guides';
  static const String guidesProgressCollection = 'guides_progress';
  
  // Subscription plans
  static const String freePlan = 'free';
  static const String basicPlan = 'basic';
  static const String proPlan = 'pro';
  
  // Usage limits
  static const int freeDailyLimit = 3;
  static const int freeMonthlyLimit = 10;
  static const int basicDailyLimit = 10;
  static const int basicMonthlyLimit = 100;
  static const int proDailyLimit = 50;
  static const int proMonthlyLimit = 500;
  
  // AI constraints
  static const int maxResponseTokens = 300;
  static const int maxChatHistoryTokens = 1200;
  static const int maxResponseWords = 120;
  
  // Red Flag Radar weights
  static const int effortWeight = 30;
  static const int respectWeight = 25;
  static const int valuesWeight = 20;
  static const int consistencyWeight = 15;
  static const int emotionalSafetyWeight = 10;
  
  // Compatibility thresholds
  static const int highConcernThreshold = 39;
  static const int mixedThreshold = 69;
  
  // Tone preferences
  static const String gentleTone = 'gentle';
  static const String directTone = 'direct';
  static const String balancedTone = 'balanced';
  
  // Crisis types
  static const List<String> crisisTypes = [
    'Anxious',
    'Confused', 
    'Unsafe',
    'Boundary needed',
    'Apology needed'
  ];
  
  // Red flags
  static const List<String> redFlags = [
    'low_effort',
    'disrespect',
    'avoidance',
    'jealousy_control',
    'inconsistency'
  ];
  
  // Strengths
  static const List<String> strengths = [
    'supportive',
    'respectful',
    'reliable',
    'shared_goals'
  ];
  
  // Notification topics
  static const String dailyFocusNotification = 'daily_focus';
  static const String eveningReflectionNotification = 'evening_reflection';
  static const String reEngagementNotification = 're_engagement';
}
