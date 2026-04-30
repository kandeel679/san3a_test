import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';

/// Global app state using ChangeNotifier + InheritedNotifier
/// Mirrors MainViewModel.kt + UserPreferencesRepository
class AppState extends ChangeNotifier {
  // Auth state
  String? savedPhone;
  String? fullName;
  AccountType _accountType = AccountType.customer;
  String? currentSetupStep;
  bool isOnboardingDone = false;
  bool isDark = false;

  bool get isAuthenticated => savedPhone != null && currentSetupStep == 'COMPLETED';
  bool get isClient => _accountType == AccountType.customer;
  bool get isProvider => _accountType == AccountType.craftsman;
  bool get isAdmin => false; // Admin handled separately

  void savePhone(String phone) {
    savedPhone = phone;
    notifyListeners();
  }

  void setOnboardingDone() {
    isOnboardingDone = true;
    notifyListeners();
  }

  void completeSetup({required String fullName, required AccountType accountType}) {
    this.fullName = fullName;
    _accountType = accountType;
    currentSetupStep = 'COMPLETED';
    notifyListeners();
  }

  void toggleDarkMode() {
    isDark = !isDark;
    notifyListeners();
  }

  void logout() {
    savedPhone = null;
    fullName = null;
    currentSetupStep = null;
    notifyListeners();
  }
}

class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    Key? key,
    required AppState notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>()!.notifier!;
  }
}
