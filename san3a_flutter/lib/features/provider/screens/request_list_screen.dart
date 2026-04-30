import 'package:flutter/material.dart';
import '../../../core/l10n/app_localizations.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('availableRequests'))),
      body: ListView.builder(
        itemCount: 5, // Mock data
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(t.translate('plumbingIssue')),
              subtitle: Text(t.translate('downtownCairo')),
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigate to send offer
                },
                child: Text(t.translate('sendOffer')),
              ),
            ),
          );
        },
      ),
    );
  }
}
