import 'package:flutter/material.dart';
import '../../../core/l10n/app_localizations.dart';

class AdminOverviewScreen extends StatelessWidget {
  const AdminOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('adminOverview'))),
      body: Center(
        child: Text(t.translate('platformStats')),
      ),
    );
  }
}
