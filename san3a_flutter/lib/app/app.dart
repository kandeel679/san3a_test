import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/app_state.dart';
import '../core/l10n/app_localizations.dart';
import '../navigation/app_router.dart';

class San3aApp extends StatelessWidget {
  const San3aApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final router = AppRouter.createRouter(appState);
    final colors = appState.isDark ? darkThemeColors : lightThemeColors;
    final isArabic = appState.isArabic;

    return San3aTheme(
      colors: colors,
      textStyle: defaultTextStyles,
      radius: defaultRadius,
      child: MaterialApp.router(
        title: 'San3a',
        locale: appState.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF5C9EFF),
          useMaterial3: true,
          brightness: appState.isDark ? Brightness.dark : Brightness.light,
          fontFamily: isArabic ? 'Cairo' : 'PlusJakartaSans',
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xFF5C9EFF),
          useMaterial3: true,
          brightness: Brightness.dark,
          fontFamily: isArabic ? 'Cairo' : 'PlusJakartaSans',
        ),
        themeMode: appState.isDark ? ThemeMode.dark : ThemeMode.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
