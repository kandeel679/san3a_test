import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';

class CraftsmanHomeScreen extends StatefulWidget {
  const CraftsmanHomeScreen({Key? key}) : super(key: key);
  @override State<CraftsmanHomeScreen> createState() => _CraftsmanHomeScreenState();
}

class _CraftsmanHomeScreenState extends State<CraftsmanHomeScreen> {
  String? _selectedServiceId;
  bool _isLoading = true;

  final _recentJobs = [
    _JobUi(id: '1', title: 'Shower not working', service: 'Plumbing', description: 'Main bathroom shower broken', location: 'Nasr City, Cairo', offers: 2),
    _JobUi(id: '2', title: 'Pipe leak under sink', service: 'Plumbing', description: 'Kitchen sink leaking badly', location: 'Maadi, Cairo', offers: 4),
  ];

  final _availableJobs = [
    _JobUi(id: '3', title: 'Install new faucet', service: 'Plumbing', description: 'Need a new kitchen faucet installed', location: 'Dokki, Giza', offers: 1),
    _JobUi(id: '4', title: 'Fix water heater', service: 'Plumbing', description: 'Water heater not heating', location: '6th October, Giza', offers: 3),
    _JobUi(id: '5', title: 'Replace outlet', service: 'Electrical', description: 'Broken power outlet in bedroom', location: 'Heliopolis, Cairo', offers: 0),
    _JobUi(id: '6', title: 'Install ceiling fan', service: 'Electrical', description: 'Need ceiling fan in living room', location: 'Smouha, Alex', offers: 2),
  ];

  final _userServices = ['Plumbing', 'Electrical'];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () { if (mounted) setState(() => _isLoading = false); });
  }

  List<_JobUi> get _filteredAvailable => _selectedServiceId == null ? _availableJobs : _availableJobs.where((j) => j.service == _selectedServiceId).toList();

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    if (_isLoading) return Scaffold(backgroundColor: theme.colors.background.screen, body: Center(child: CircularProgressIndicator(color: theme.colors.brand.primary)));

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(child: Column(children: [
        Container(color: theme.colors.background.card, padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Good Morning, Ahmed', style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary)),
            const SizedBox(height: 4),
            Row(children: [Icon(Icons.location_on_outlined, size: 16, color: theme.colors.shade.secondary), const SizedBox(width: 4), Text('Cairo, Egypt', style: theme.textStyle.bodySmallMedium.copyWith(color: theme.colors.shade.secondary))]),
          ])),
          GestureDetector(onTap: () => context.push('/notifications'), child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colors.background.screen, shape: BoxShape.circle), child: Icon(Icons.notifications_outlined, color: theme.colors.shade.primary))),
        ])),
        Expanded(child: ListView(padding: const EdgeInsets.only(top: 16, bottom: 16), children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('Your Stats', style: theme.textStyle.titleMedium.copyWith(color: theme.colors.shade.primary))),
          const SizedBox(height: 12),
          const StatsContainer(jobsDone: 10, earnings: 2500, rating: 4.7),
          const SizedBox(height: 24),
          if (_recentJobs.isNotEmpty) ...[
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('Recent Plumbing Jobs', style: theme.textStyle.titleMedium.copyWith(color: theme.colors.shade.primary))),
            const SizedBox(height: 12),
            SizedBox(height: 200, child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, itemCount: _recentJobs.length, separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) { final j = _recentJobs[i]; return RequestCard(title: j.title, type: j.service, offers: j.offers, description: j.description, location: j.location, maxWidth: 300, onClick: () => context.push('/request_details/${j.id}')); },
            )),
            const SizedBox(height: 24),
          ],
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('Available Jobs', style: theme.textStyle.titleMedium.copyWith(color: theme.colors.shade.primary))),
          const SizedBox(height: 12),
          SizedBox(height: 40, child: ListView(padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, children: [
            AppChip(label: 'All', isSelected: _selectedServiceId == null, onTap: () => setState(() => _selectedServiceId = null)),
            const SizedBox(width: 8),
            ..._userServices.map((s) => Padding(padding: const EdgeInsets.only(right: 8), child: AppChip(label: s, isSelected: _selectedServiceId == s, onTap: () => setState(() => _selectedServiceId = s)))),
          ])),
          const SizedBox(height: 12),
          if (_filteredAvailable.isEmpty) Padding(padding: const EdgeInsets.all(40), child: Column(children: [Icon(Icons.work_off_outlined, size: 64, color: theme.colors.shade.tertiary), const SizedBox(height: 16), Text('No jobs for this category', style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.secondary))]))
          else ...(_filteredAvailable.map((j) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), child: RequestCard(title: j.title, type: j.service, offers: j.offers, description: j.description, location: j.location, onClick: () => context.push('/request_details/${j.id}'))))),
        ])),
      ])),
    );
  }
}

class _JobUi { final String id, title, service, description, location; final int offers; const _JobUi({required this.id, required this.title, required this.service, required this.description, required this.location, required this.offers}); }
