import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  // Form data
  int? _age;
  String? _gender;
  String? _country;
  final List<String> _selectedStruggles = [];
  final TextEditingController _reflectionController = TextEditingController();
  bool _dailyCheckins = true;
  String _tonePref = AppConstants.balancedTone;

  final List<String> _struggles = [
    'Red flags',
    'Compatibility',
    'What to say',
    'Boundaries',
    'Not rushing',
    'Clarity of intentions',
  ];

  final List<String> _genders = ['Woman', 'Man', 'Non-binary', 'Prefer not to say'];
  final List<String> _toneOptions = [
    AppConstants.gentleTone,
    AppConstants.directTone,
    AppConstants.balancedTone,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _reflectionController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final user = authService.currentUser;
      
      if (user != null) {
        await authService.completeOnboarding(user.uid, {
          'age': _age,
          'gender': _gender,
          'country': _country,
          'struggles': _selectedStruggles,
          'reflection': _reflectionController.text.trim(),
          'commitments': {
            'daily_checkins_enabled': _dailyCheckins,
          },
          'tone_pref': _tonePref,
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to complete onboarding: ${e.toString()}'),
            backgroundColor: AppTheme.redFlag,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
                      onPressed: _previousPage,
                    ),
                  const Spacer(),
                  Text(
                    '${_currentPage + 1} of 7',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumGray,
                    ),
                  ),
                ],
              ),
            ),
            
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 7,
                backgroundColor: AppTheme.darkGray,
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
              ),
            ),
            
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildWelcomePage(),
                  _buildContextPage(),
                  _buildStrugglesPage(),
                  _buildReflectionPage(),
                  _buildCommitmentPage(),
                  _buildTonePreferencePage(),
                  _buildPrivacyPage(),
                ],
              ),
            ),
            
            // Navigation button
            Padding(
              padding: const EdgeInsets.all(24),
              child: AppButton(
                text: _currentPage == 6 ? 'Get Started' : 'Continue',
                onPressed: _isLoading ? null : _nextPage,
                isLoading: _isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGold.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology,
              size: 60,
              color: AppTheme.darkBackground,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Welcome to ${AppConstants.appName}',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Not a dating app. Your private mentor for red flags & compatibility.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: AppTheme.primaryGold,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your conversations stay private. We never share your personal data.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.whiteText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us about yourself',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This helps us personalize your experience (optional)',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          
          // Age input
          AppTextField(
            label: 'Age',
            keyboardType: TextInputType.number,
            onChanged: (value) => _age = int.tryParse(value),
            hint: 'Enter your age',
          ),
          const SizedBox(height: 20),
          
          // Gender selection
          Text(
            'Gender',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _genders.map((gender) => _buildChip(
              gender,
              _gender == gender,
              () => setState(() => _gender = gender),
            )).toList(),
          ),
          const SizedBox(height: 20),
          
          // Country input
          AppTextField(
            label: 'Country',
            onChanged: (value) => _country = value,
            hint: 'Enter your country',
          ),
        ],
      ),
    );
  }

  Widget _buildStrugglesPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What do you struggle with most?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select all that apply',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _struggles.map((struggle) => _buildChip(
              struggle,
              _selectedStruggles.contains(struggle),
              () => setState(() {
                if (_selectedStruggles.contains(struggle)) {
                  _selectedStruggles.remove(struggle);
                } else {
                  _selectedStruggles.add(struggle);
                }
              }),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReflectionPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why now?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What brought you here today? (optional)',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          
          AppTextField(
            controller: _reflectionController,
            label: 'Your reflection',
            hint: 'Share what\'s on your mind...',
            maxLines: 4,
            minLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildCommitmentPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily check-ins',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Small daily reflections create big insights over time',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enable daily check-ins',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.whiteText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Get gentle daily prompts for reflection',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _dailyCheckins,
                  onChanged: (value) => setState(() => _dailyCheckins = value),
                  activeColor: AppTheme.primaryGold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTonePreferencePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How should I communicate?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your preferred tone',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          
          Column(
            children: _toneOptions.map((tone) => _buildToneOption(tone)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.security,
            size: 80,
            color: AppTheme.primaryGold,
          ),
          const SizedBox(height: 32),
          Text(
            'Your privacy is our priority',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Your conversations and notes are encrypted and never shared. You can export or delete your data anytime.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppTheme.greenStrength, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'End-to-end encryption',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.whiteText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppTheme.greenStrength, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'No data sharing with third parties',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.whiteText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppTheme.greenStrength, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Full data control',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.whiteText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGold : AppTheme.darkSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGold : AppTheme.darkGray,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? AppTheme.blackText : AppTheme.whiteText,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildToneOption(String tone) {
    final isSelected = _tonePref == tone;
    final descriptions = {
      AppConstants.gentleTone: 'Warm and encouraging approach',
      AppConstants.directTone: 'Straightforward and honest feedback',
      AppConstants.balancedTone: 'Mix of supportive and direct',
    };

    return GestureDetector(
      onTap: () => setState(() => _tonePref = tone),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGold.withOpacity(0.1) : AppTheme.darkSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGold : AppTheme.darkGray,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppTheme.primaryGold : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppTheme.primaryGold : AppTheme.mediumGray,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: AppTheme.blackText)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tone.substring(0, 1).toUpperCase() + tone.substring(1),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.whiteText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descriptions[tone] ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.mediumGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
