import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/utils/app_state.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../data/models/user_model.dart';

/// Mirrors AccountScreen.kt — 7-step multi-step setup wizard
class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({Key? key}) : super(key: key);

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  int _currentStep = 0;
  AccountType? _selectedAccountType;
  final Set<String> _selectedServices = {};
  int? _selectedGovernorateId;
  int? _selectedCityId;
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _workDescController = TextEditingController();

  // Available services categories — keys used for localization
  static const _serviceKeys = [
    {'id': 'plumbing', 'titleKey': 'plumbing', 'icon': Icons.plumbing},
    {'id': 'electrical', 'titleKey': 'electrical', 'icon': Icons.electrical_services},
    {'id': 'painting', 'titleKey': 'painting', 'icon': Icons.format_paint},
    {'id': 'tiling', 'titleKey': 'tiling', 'icon': Icons.grid_on},
    {'id': 'locksmith', 'titleKey': 'locksmith', 'icon': Icons.lock},
    {'id': 'appliance', 'titleKey': 'applianceRepair', 'icon': Icons.kitchen},
  ];

  static const _governorateKeys = [
    {'id': 1, 'nameKey': 'cairo'},
    {'id': 2, 'nameKey': 'giza'},
    {'id': 3, 'nameKey': 'alexandria'},
    {'id': 4, 'nameKey': 'qalyubia'},
  ];

  static const _cities = {
    1: [{'id': 1, 'name': 'Nasr City'}, {'id': 2, 'name': 'Heliopolis'}, {'id': 3, 'name': 'Maadi'}],
    2: [{'id': 4, 'name': 'Dokki'}, {'id': 5, 'name': '6th October'}, {'id': 6, 'name': 'Sheikh Zayed'}],
    3: [{'id': 7, 'name': 'Smouha'}, {'id': 8, 'name': 'Montaza'}],
    4: [{'id': 9, 'name': 'Shubra El Kheima'}, {'id': 10, 'name': 'Qalyub'}],
  };

  List<String> _stepTitles(AppLocalizations t) => [
    t.translate('accountType'),
    t.translate('selectServices'),
    t.translate('yourLocation'),
    t.translate('personalInfo'),
    t.translate('showcaseWork'),
    t.translate('uploadNationalId'),
    t.translate('allDone'),
  ];

  bool get _canProceed {
    switch (_currentStep) {
      case 0: return _selectedAccountType != null;
      case 1: return _selectedServices.isNotEmpty;
      case 2: return _selectedGovernorateId != null && _selectedCityId != null && _addressController.text.isNotEmpty;
      case 3: return _nameController.text.isNotEmpty;
      case 4: return true; // Optional
      case 5: return true; // Optional for demo
      case 6: return true;
      default: return false;
    }
  }

  void _nextStep() {
    if (_currentStep == 6) {
      _finishSetup();
      return;
    }
    setState(() => _currentStep++);
  }

  void _previousStep() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _finishSetup() {
    final appState = AppStateProvider.of(context);
    appState.completeSetup(
      fullName: _nameController.text,
      accountType: _selectedAccountType ?? AccountType.customer,
    );
    if (_selectedAccountType == AccountType.craftsman) {
      context.go('/craftsman');
    } else {
      context.go('/customer');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final t = AppLocalizations.of(context);
    final titles = _stepTitles(t);

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      appBar: _currentStep > 0 && _currentStep < 6
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: theme.colors.shade.primary),
                onPressed: _previousStep,
              ),
              title: Text(titles[_currentStep], style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary)),
              centerTitle: true,
            )
          : null,
      body: Column(
        children: [
          // Progress bar
          if (_currentStep < 6)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / 7,
                backgroundColor: theme.colors.shade.quaternary,
                valueColor: AlwaysStoppedAnimation(theme.colors.brand.primary),
                borderRadius: BorderRadius.circular(4),
                minHeight: 6,
              ),
            ),
          Expanded(child: _buildStepContent(theme, t)),
          // Bottom button
          Padding(
            padding: const EdgeInsets.all(24),
            child: AppButton(
              text: _currentStep == 6 ? t.translate('startUsingSan3a') : t.translate('next'),
              state: _canProceed ? AppButtonState.enable : AppButtonState.disable,
              onPressed: _canProceed ? _nextStep : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(San3aTheme theme, AppLocalizations t) {
    switch (_currentStep) {
      case 0: return _buildAccountTypeStep(theme, t);
      case 1: return _buildServicesStep(theme, t);
      case 2: return _buildLocationStep(theme, t);
      case 3: return _buildPersonalInfoStep(theme, t);
      case 4: return _buildWorkShowcaseStep(theme, t);
      case 5: return _buildNationalIdStep(theme, t);
      case 6: return _buildCompletedStep(theme, t);
      default: return const SizedBox();
    }
  }

  Widget _buildAccountTypeStep(San3aTheme theme, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(t.translate('whatAccountType'), style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary)),
          const SizedBox(height: 8),
          Text(t.translate('chooseHowToUse'), style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary)),
          const SizedBox(height: 32),
          _AccountTypeCard(
            icon: Icons.person,
            title: t.translate('customer'),
            description: t.translate('customerDesc'),
            isSelected: _selectedAccountType == AccountType.customer,
            onTap: () => setState(() => _selectedAccountType = AccountType.customer),
            theme: theme,
          ),
          const SizedBox(height: 16),
          _AccountTypeCard(
            icon: Icons.handyman,
            title: t.translate('craftsman'),
            description: t.translate('craftsmanDesc'),
            isSelected: _selectedAccountType == AccountType.craftsman,
            onTap: () => setState(() => _selectedAccountType = AccountType.craftsman),
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesStep(San3aTheme theme, AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedAccountType == AccountType.craftsman
                ? t.translate('whatServicesOffer')
                : t.translate('whatServicesLooking'),
            style: theme.textStyle.titleLarge.copyWith(color: theme.colors.shade.primary),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: _serviceKeys.map((s) {
                final id = s['id'] as String;
                final isSelected = _selectedServices.contains(id);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (isSelected) { _selectedServices.remove(id); } else { _selectedServices.add(id); }
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colors.brand.tertiary : theme.colors.background.card,
                      borderRadius: BorderRadius.circular(theme.radius.extraLarge),
                      border: Border.all(
                        color: isSelected ? theme.colors.brand.primary : theme.colors.stroke.primary,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(s['icon'] as IconData, size: 32, color: isSelected ? theme.colors.brand.primary : theme.colors.shade.secondary),
                        const SizedBox(height: 8),
                        Text(t.translate(s['titleKey'] as String), style: theme.textStyle.bodyMediumMedium.copyWith(color: isSelected ? theme.colors.brand.primary : theme.colors.shade.primary)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStep(San3aTheme theme, AppLocalizations t) {
    final cities = _selectedGovernorateId != null ? (_cities[_selectedGovernorateId] ?? []) : [];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate('whereLocated'), style: theme.textStyle.titleLarge.copyWith(color: theme.colors.shade.primary)),
          const SizedBox(height: 24),
          DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: t.translate('governorate'),
              filled: true,
              fillColor: theme.colors.background.card,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radius.large)),
            ),
            value: _selectedGovernorateId,
            items: _governorateKeys.map((g) => DropdownMenuItem(value: g['id'] as int, child: Text(t.translate(g['nameKey'] as String)))).toList(),
            onChanged: (v) => setState(() { _selectedGovernorateId = v; _selectedCityId = null; }),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: t.translate('city'),
              filled: true,
              fillColor: theme.colors.background.card,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radius.large)),
            ),
            value: _selectedCityId,
            items: cities.map((c) => DropdownMenuItem(value: c['id'] as int, child: Text(c['name'] as String))).toList(),
            onChanged: (v) => setState(() => _selectedCityId = v),
          ),
          const SizedBox(height: 16),
          AppTextField(label: t.translate('addressDetails'), hint: t.translate('addressHint'), controller: _addressController, onChanged: (_) => setState(() {})),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep(San3aTheme theme, AppLocalizations t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate('personalInformation'), style: theme.textStyle.titleLarge.copyWith(color: theme.colors.shade.primary)),
          const SizedBox(height: 24),
          Center(
            child: Stack(
              children: [
                CircleAvatar(radius: 50, backgroundColor: theme.colors.shade.quinary, child: Icon(Icons.person, size: 50, color: theme.colors.shade.tertiary)),
                Positioned(
                  bottom: 0, right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: theme.colors.brand.primary,
                    child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(label: t.translate('fullName'), controller: _nameController, onChanged: (_) => setState(() {})),
        ],
      ),
    );
  }

  Widget _buildWorkShowcaseStep(San3aTheme theme, AppLocalizations t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate('showcaseYourWork'), style: theme.textStyle.titleLarge.copyWith(color: theme.colors.shade.primary)),
          const SizedBox(height: 8),
          Text(t.translate('addPhotosDesc'), style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary)),
          const SizedBox(height: 24),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: theme.colors.background.card,
              borderRadius: BorderRadius.circular(theme.radius.extraLarge),
              border: Border.all(color: theme.colors.stroke.primary, style: BorderStyle.solid),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate, size: 48, color: theme.colors.shade.tertiary),
                  const SizedBox(height: 8),
                  Text(t.translate('addPhotos'), style: theme.textStyle.bodyMediumMedium.copyWith(color: theme.colors.shade.tertiary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppTextField(label: t.translate('workDescription'), hint: t.translate('workDescHint'), controller: _workDescController, maxLines: 4),
        ],
      ),
    );
  }

  Widget _buildNationalIdStep(San3aTheme theme, AppLocalizations t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.translate('verifyIdentity'), style: theme.textStyle.titleLarge.copyWith(color: theme.colors.shade.primary)),
          const SizedBox(height: 8),
          Text(t.translate('uploadIdDesc'), style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary)),
          const SizedBox(height: 24),
          _IdUploadCard(label: t.translate('nationalIdFront'), theme: theme),
          const SizedBox(height: 16),
          _IdUploadCard(label: t.translate('nationalIdBack'), theme: theme),
        ],
      ),
    );
  }

  Widget _buildCompletedStep(San3aTheme theme, AppLocalizations t) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colors.additional.secondary.success,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, size: 60, color: theme.colors.additional.primary.success),
            ),
            const SizedBox(height: 32),
            Text(t.translate('youreAllSet'), style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary)),
            const SizedBox(height: 16),
            Text(
              t.translate('accountCreated'),
              style: theme.textStyle.bodyMediumRegular.copyWith(color: theme.colors.shade.secondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  final San3aTheme theme;

  const _AccountTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.brand.tertiary : theme.colors.background.card,
          borderRadius: BorderRadius.circular(theme.radius.extraLarge),
          border: Border.all(
            color: isSelected ? theme.colors.brand.primary : theme.colors.stroke.primary,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? theme.colors.brand.secondary : theme.colors.shade.quinary,
                borderRadius: BorderRadius.circular(theme.radius.large),
              ),
              child: Icon(icon, color: isSelected ? theme.colors.brand.primary : theme.colors.shade.secondary, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textStyle.bodyLargeSemibold.copyWith(color: theme.colors.shade.primary)),
                  const SizedBox(height: 4),
                  Text(description, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: theme.colors.brand.primary)
            else
              Icon(Icons.radio_button_unchecked, color: theme.colors.shade.quaternary),
          ],
        ),
      ),
    );
  }
}

class _IdUploadCard extends StatelessWidget {
  final String label;
  final San3aTheme theme;
  const _IdUploadCard({required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: theme.colors.background.card,
        borderRadius: BorderRadius.circular(theme.radius.extraLarge),
        border: Border.all(color: theme.colors.stroke.primary),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file, size: 32, color: theme.colors.shade.tertiary),
            const SizedBox(height: 8),
            Text(label, style: theme.textStyle.bodyMediumMedium.copyWith(color: theme.colors.shade.tertiary)),
          ],
        ),
      ),
    );
  }
}
