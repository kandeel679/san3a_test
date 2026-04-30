import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = San3aTheme.of(context);
    final requests = [
      _ReqUi(title: 'Shower repair', status: 'ONGOING', service: 'Plumbing', date: 'Apr 28, 2026', offers: 3),
      _ReqUi(title: 'Install ceiling fan', status: 'COMPLETED', service: 'Electrical', date: 'Apr 25, 2026', offers: 5),
      _ReqUi(title: 'Paint bedroom', status: 'CANCELLED', service: 'Painting', date: 'Apr 20, 2026', offers: 1),
    ];

    return Scaffold(
      backgroundColor: theme.colors.background.screen,
      body: SafeArea(child: Column(children: [
        Container(color: theme.colors.background.card, padding: const EdgeInsets.all(16), child: Align(alignment: Alignment.centerLeft, child: Text('My Requests', style: theme.textStyle.titleXLarge.copyWith(color: theme.colors.shade.primary)))),
        Expanded(child: requests.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.inbox_outlined, size: 64, color: theme.colors.shade.tertiary), const SizedBox(height: 16), Text('No requests yet', style: theme.textStyle.titleSmall.copyWith(color: theme.colors.shade.secondary))]))
          : ListView.separated(
              padding: const EdgeInsets.all(16), itemCount: requests.length, separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final r = requests[i];
                final statusColor = r.status == 'ONGOING' ? theme.colors.additional.primary.blue : r.status == 'COMPLETED' ? theme.colors.additional.primary.success : theme.colors.additional.primary.error;
                final statusBg = r.status == 'ONGOING' ? theme.colors.additional.secondary.blue : r.status == 'COMPLETED' ? theme.colors.additional.secondary.success : theme.colors.additional.secondary.error;
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: theme.colors.background.card, borderRadius: BorderRadius.circular(theme.radius.extraLarge), border: Border.all(color: theme.colors.stroke.primary)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text(r.title, style: theme.textStyle.bodyLargeSemibold.copyWith(color: theme.colors.shade.primary))),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(theme.radius.full)), child: Text(r.status, style: theme.textStyle.labelMediumSemibold.copyWith(color: statusColor))),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      Icon(Icons.build_outlined, size: 14, color: theme.colors.shade.tertiary), const SizedBox(width: 4),
                      Text(r.service, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary)),
                      const SizedBox(width: 16),
                      Icon(Icons.calendar_today_outlined, size: 14, color: theme.colors.shade.tertiary), const SizedBox(width: 4),
                      Text(r.date, style: theme.textStyle.bodySmallRegular.copyWith(color: theme.colors.shade.secondary)),
                      const Spacer(),
                      Text('${r.offers} offers', style: theme.textStyle.bodySmallMedium.copyWith(color: theme.colors.brand.primary)),
                    ]),
                  ]),
                );
              },
            )),
      ])),
    );
  }
}

class _ReqUi { final String title, status, service, date; final int offers; const _ReqUi({required this.title, required this.status, required this.service, required this.date, required this.offers}); }
