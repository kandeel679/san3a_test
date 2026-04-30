import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/app_state.dart';
import '../navigation/app_router.dart';

class San3aApp extends StatelessWidget {
  const San3aApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final router = AppRouter.createRouter(appState);
    final colors = appState.isDark ? darkThemeColors : lightThemeColors;

    return San3aTheme(
      colors: colors,
      textStyle: defaultTextStyles,
      radius: defaultRadius,
      child: MaterialApp.router(
        title: 'San3a',
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF5C9EFF),
          useMaterial3: true,
          brightness: appState.isDark ? Brightness.dark : Brightness.light,
          fontFamily: 'PlusJakartaSans',
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xFF5C9EFF),
          useMaterial3: true,
          brightness: Brightness.dark,
          fontFamily: 'PlusJakartaSans',
        ),
        themeMode: appState.isDark ? ThemeMode.dark : ThemeMode.light,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
