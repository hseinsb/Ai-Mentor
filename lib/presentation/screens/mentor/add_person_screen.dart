import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class AddPersonScreen extends ConsumerStatefulWidget {
  const AddPersonScreen({super.key});

  @override
  ConsumerState<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends ConsumerState<AddPersonScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  // Form data
  final TextEditingController _nameController = TextEditingController();
  String? _knownDuration;
  String? _initiationFreq;
  String? _convoTreatment;
  String? _valuesKnown;
  String? _userFeeling;
  String? _primaryHelpNeed;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitProfile();
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

  Future<void> _submitProfile() async {
    setState(() => _isLoading = true);

    // TODO: Save profile to Firestore and run initial analysis
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    if (mounted) {
      // Navigate to person detail screen
      context.go('/mentor/person/new');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteText),
          onPressed: () => _currentPage > 0 ? _previousPage() : context.pop(),
        ),
        title: Text(
          'Add Person',
          style: TextStyle(color: AppTheme.whiteText),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentPage + 1} of 7',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.mediumGray,
                      ),
                    ),
                    Text(
                      '${((_currentPage + 1) / 7 * 100).round()}%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (_currentPage + 1) / 7,
                  backgroundColor: AppTheme.darkGray,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                ),
              ],
            ),
          ),

          // Page content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: [
                _buildNamePage(),
                _buildKnownDurationPage(),
                _buildInitiationFreqPage(),
                _buildConvoTreatmentPage(),
                _buildValuesKnownPage(),
                _buildUserFeelingPage(),
                _buildPrimaryHelpNeedPage(),
              ],
            ),
          ),

          // Navigation button
          Padding(
            padding: const EdgeInsets.all(24),
            child: AppButton(
              text: _currentPage == 6 ? 'Analyze Profile' : 'Continue',
              onPressed: _isLoading ? null : _nextPage,
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNamePage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What should I call them?',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can use their real name or a nickname',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          AppTextField(
            controller: _nameController,
            label: 'Name or Nickname',
            hint: 'e.g., Alex, J, or their actual name',
          ),
        ],
      ),
    );
  }

  Widget _buildKnownDurationPage() {
    final options = ['Just met', 'Weeks', 'Months', '1+ year'];
    
    return _buildOptionPage(
      title: 'How long have you known them?',
      subtitle: 'This helps me understand the relationship stage',
      options: options,
      selectedValue: _knownDuration,
      onChanged: (value) => setState(() => _knownDuration = value),
    );
  }

  Widget _buildInitiationFreqPage() {
    final options = ['Daily', 'Few times a week', 'Rarely', 'Only after you text'];
    
    return _buildOptionPage(
      title: 'How often do they initiate contact?',
      subtitle: 'This reveals their level of interest and effort',
      options: options,
      selectedValue: _initiationFreq,
      onChanged: (value) => setState(() => _initiationFreq = value),
    );
  }

  Widget _buildConvoTreatmentPage() {
    final options = ['Respectful', 'Playful', 'Dismissive', 'Mixed'];
    
    return _buildOptionPage(
      title: 'How do they treat you in conversation?',
      subtitle: 'Think about their tone and how they respond to you',
      options: options,
      selectedValue: _convoTreatment,
      onChanged: (value) => setState(() => _convoTreatment = value),
    );
  }

  Widget _buildValuesKnownPage() {
    final options = ['Career focused', 'Family oriented', 'Faith important', 'Not sure yet'];
    
    return _buildOptionPage(
      title: 'What do you know about their values?',
      subtitle: 'Have they shared what matters most to them?',
      options: options,
      selectedValue: _valuesKnown,
      onChanged: (value) => setState(() => _valuesKnown = value),
    );
  }

  Widget _buildUserFeelingPage() {
    final options = ['Excited', 'Unsure', 'Cautious', 'Doubtful', 'Serious'];
    
    return _buildOptionPage(
      title: 'How do you feel about them?',
      subtitle: 'Trust your gut feeling',
      options: options,
      selectedValue: _userFeeling,
      onChanged: (value) => setState(() => _userFeeling = value),
    );
  }

  Widget _buildPrimaryHelpNeedPage() {
    final options = [
      'Spotting red flags',
      'Understanding compatibility',
      'Knowing what to say',
      'Setting boundaries',
      'Not rushing things',
      'Getting clarity on intentions',
    ];
    
    return _buildOptionPage(
      title: 'What do you need most help with?',
      subtitle: 'I\'ll focus my guidance on this area',
      options: options,
      selectedValue: _primaryHelpNeed,
      onChanged: (value) => setState(() => _primaryHelpNeed = value),
    );
  }

  Widget _buildOptionPage({
    required String title,
    required String subtitle,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: AppTheme.whiteText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: 32),
          ...options.map((option) => _buildOptionTile(
            option,
            selectedValue == option,
            () => onChanged(option),
          )),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
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
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.whiteText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
