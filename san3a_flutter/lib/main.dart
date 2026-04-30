import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/utils/app_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase: uncomment when google-services.json is added
  // try {
  //   await Firebase.initializeApp();
  // } catch (e) {
  //   debugPrint("Firebase init failed: $e");
  // }

  final appState = AppState();

  runApp(
    AppStateProvider(
      notifier: appState,
      child: const San3aApp(),
    ),
  );
}
