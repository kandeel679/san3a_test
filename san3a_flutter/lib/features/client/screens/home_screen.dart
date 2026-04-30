import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../../core/utils/app_state.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../data/models/service_model.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);
  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String _searchQuery = '';
  bool _isLoading = true;

  final List<Service> _services = [
    Service(id: '1', title: 'Plumbing', description: 'Fix leaks, install pipes, repair water systems', suggestions: ['Shower repair', 'Pipe leak', 'Water heater'], imageUrl: '', hint: 'Describe the plumbing issue', iconImageUrl: '', colorCode: '#4C8FD3'),
    Service(id: '2', title: 'Electrical Work', description: 'Wiring, outlets, switches, electrical repairs', suggestions: ['Power outlet', 'Light fixture', 'Breaker issue'], imageUrl: '', hint: 'Describe the electrical issue', iconImageUrl: '', colorCode: '#E3B339'),
    Service(id: '3', title: 'Painting', description: 'Interior and exterior painting services', suggestions: ['Wall painting', 'Touch up', 'Full room'], imageUrl: '', hint: 'Describe the painting job', iconImageUrl: '', colorCode: '#6DBF7E'),
    Service(id: '4', title: 'Tiling', description: 'Floor and wall tiling installation and repair', suggestions: ['Bathroom tiles', 'Kitchen tiles', 'Floor repair'], imageUrl: '', hint: 'Describe the tiling job', iconImageUrl: '', colorCode: '#9A83CE'),
    Service(id: '5', title: 'Locksmith', description: 'Lock installation, repair, key duplication', suggestions: ['Lock change', 'Key copy', 'Door lock'], imageUrl: '', hint: 'Describe the locksmith service', iconImageUrl: '', colorCode: '#F56C6C'),
    Service(id: '6', title: 'Appliance Repair', description: 'Washing machine, refrigerator, AC repair', suggestions: ['AC repair', 'Washing machine', 'Fridge repair'], imageUrl: '', hint: 'Describe the appliance issue', iconImageUrl: '', colorCode: '#4BA8A7'),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  List<Service> get _filtered {
    if (_searchQuery.isEmpty) return _services;
    return _services.where((s) => s.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  void _openRequest(Service s) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => _RequestSheet(service: s),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final appState = AppStateProvider.of(context);
    final t = AppLocalizations.of(context);
    if (_isLoading) return Scaffold(backgroundColor: theme.colors.background.screen, body: Center(child: CircularProgressIndicator(color: theme.colors.brand.primary)));

    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? t.translate('goodMorning') : hour < 17 ? t.translate('goodAfternoon') : t.translate('goodEvening');

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(child: Column(children: [
        Container(color: theme.colors.background.card, padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$greeting, ${appState.fullName ?? "User"}', style: theme.textStyle.bodyMediumMedium.copyWith(color: theme.colors.shade.primary)),
            const SizedBox(height: 4),
            Row(children: [Icon(Icons.location_on_outlined, size: 16, color: theme.colors.shade.secondary), const SizedBox(width: 4), Text('${t.translate('cairo')}, Egypt', style: theme.textStyle.bodySmallMedium.copyWith(color: theme.colors.shade.secondary))]),
          ])),
          GestureDetector(onTap: () => context.push('/notifications'), child: Stack(children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: theme.colors.background.screen, shape: BoxShape.circle), child: Icon(Icons.notifications_outlined, color: theme.colors.shade.primary)),
            Positioned(right: 4, top: 4, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: theme.colors.additional.primary.error, shape: BoxShape.circle), child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))),
          ])),
        ])),
        Expanded(child: ListView(children: [
          const SizedBox(height: 16),
          AppSearchBar(value: _searchQuery, onValueChange: (v) => setState(() => _searchQuery = v), hint: t.translate('searchService')),
          const SizedBox(height: 24),
          if (_searchQuery.isEmpty) ...[
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(t.translate('mostRequested'), style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary))),
            const SizedBox(height: 12),
            SizedBox(height: 100, child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16), scrollDirection: Axis.horizontal, itemCount: 3, separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final s = _services[i];
                final c = _parseColor(s.colorCode);
                return GestureDetector(onTap: () => _openRequest(s), child: Container(width: 140, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: c.withOpacity(0.3))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Icon(_icon(s.id), color: c, size: 28), const SizedBox(height: 8), Text(s.title, style: theme.textStyle.bodySmallSemibold.copyWith(color: theme.colors.shade.primary))])));
              },
            )),
            const SizedBox(height: 24),
          ],
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(_searchQuery.isEmpty ? t.translate('findWhatYouNeed') : t.translate('results'), style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary))),
          const SizedBox(height: 12),
          if (_filtered.isEmpty) Padding(padding: const EdgeInsets.all(40), child: Column(children: [Icon(Icons.search_off, size: 64, color: theme.colors.shade.tertiary), const SizedBox(height: 16), Text(t.translate('noResults'), style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.secondary))]))
          else ...(_filtered.map((s) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), child: CategoryItem(title: s.title, description: s.description, serviceImageUrl: s.imageUrl, onTap: () => _openRequest(s))))),
          if (_searchQuery.isEmpty) Padding(padding: const EdgeInsets.all(16), child: AdCard(title: t.translate('adTitle'), caption: t.translate('adCaption'), buttonTitle: t.translate('becomeACraftsman'))),
          const SizedBox(height: 24),
        ])),
      ])),
    );
  }

  Color _parseColor(String c) { try { return Color(int.parse(c.replaceFirst('#', 'FF'), radix: 16)); } catch (_) { return Colors.blue; } }
  IconData _icon(String id) { switch(id) { case '1': return Icons.plumbing; case '2': return Icons.electrical_services; case '3': return Icons.format_paint; case '4': return Icons.grid_on; case '5': return Icons.lock; case '6': return Icons.kitchen; default: return Icons.build; } }
}

class _RequestSheet extends StatefulWidget {
  final Service service;
  const _RequestSheet({required this.service});
  @override State<_RequestSheet> createState() => _RequestSheetState();
}

class _RequestSheetState extends State<_RequestSheet> {
  int _step = 0; String _title = ''; String _desc = '';

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final t = AppLocalizations.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      decoration: BoxDecoration(color: theme.colors.background.bottomSheet, borderRadius: const BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4, margin: const EdgeInsets.only(top: 12), decoration: BoxDecoration(color: theme.colors.shade.quaternary, borderRadius: BorderRadius.circular(2))),
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          if (_step > 0) IconButton(icon: Icon(Icons.arrow_back_ios, size: 18, color: theme.colors.shade.primary), onPressed: () => setState(() => _step--)),
          Expanded(child: Text(widget.service.title, style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.primary))),
          IconButton(icon: Icon(Icons.close, color: theme.colors.shade.secondary), onPressed: () => Navigator.pop(context)),
        ])),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: List.generate(4, (i) => Expanded(child: Container(height: 4, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(color: i <= _step ? theme.colors.brand.primary : theme.colors.shade.quaternary, borderRadius: BorderRadius.circular(2))))))),
        const SizedBox(height: 16),
        Flexible(child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 16), child: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.translate('whatNeedHelp'), style: theme.textStyle.bodyLargeMedium.copyWith(color: theme.colors.shade.primary)), const SizedBox(height: 16),
            Wrap(spacing: 8, runSpacing: 8, children: widget.service.suggestions.map((s) => AppChip(label: s, isSelected: _title == s, onTap: () => setState(() => _title = s))).toList()),
            const SizedBox(height: 16), AppTextField(hint: widget.service.hint, onChanged: (v) => setState(() => _title = v)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t.translate('describeProblem'), style: theme.textStyle.bodyLargeMedium.copyWith(color: theme.colors.shade.primary)), const SizedBox(height: 16), AppTextField(hint: t.translate('describe'), maxLines: 5, onChanged: (v) => setState(() => _desc = v))]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t.translate('whereAreYou'), style: theme.textStyle.bodyLargeMedium.copyWith(color: theme.colors.shade.primary)), const SizedBox(height: 16), AppTextField(hint: t.translate('governorate')), const SizedBox(height: 12), AppTextField(hint: t.translate('city')), const SizedBox(height: 12), AppTextField(hint: t.translate('address'))]),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t.translate('addPhotosOptional'), style: theme.textStyle.bodyLargeMedium.copyWith(color: theme.colors.shade.primary)), const SizedBox(height: 16), Container(height: 140, decoration: BoxDecoration(color: theme.colors.background.bottomSheetCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: theme.colors.stroke.primary)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt_outlined, size: 40, color: theme.colors.shade.tertiary), const SizedBox(height: 8), Text(t.translate('tapToAddPhotos'), style: theme.textStyle.bodySmallMedium.copyWith(color: theme.colors.shade.tertiary))])))]),
        ][_step])),
        Padding(padding: const EdgeInsets.all(16), child: AppButton(text: _step == 3 ? t.translate('createRequest') : t.translate('next'), state: (_step == 0 && _title.isEmpty) || (_step == 1 && _desc.isEmpty) ? AppButtonState.disable : AppButtonState.enable, onPressed: () {
          if (_step < 3) setState(() => _step++);
          else { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.translate('requestCreated')), backgroundColor: San3aTheme.of(context).colors.additional.primary.success)); }
        })),
      ]),
    );
  }
}
