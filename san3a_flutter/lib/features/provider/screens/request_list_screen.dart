import 'package:flutter/material.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Requests')),
      body: ListView.builder(
        itemCount: 5, // Mock data
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: const Text('Plumbing Issue'),
              subtitle: const Text('Downtown Cairo - Needs fixing ASAP'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Navigate to send offer
                },
                child: const Text('Send Offer'),
              ),
            ),
          );
        },
      ),
    );
  }
}
