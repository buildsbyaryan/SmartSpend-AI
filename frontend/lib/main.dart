import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_spend_ai/providers/budget_provider.dart';
import 'package:smart_spend_ai/providers/settings_provider.dart';

import 'providers/auth_provider.dart';
import 'providers/expense_provider.dart';
import 'providers/income_provider.dart';
import 'providers/theme_provider.dart';

import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartSpendApp());
}

class SmartSpendApp extends StatelessWidget {
  const SmartSpendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(create: (_) => ExpenseProvider()),

        ChangeNotifierProvider(create: (_) => IncomeProvider()),

        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
      ],

      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: "SmartSpend AI",

            themeMode: themeProvider.themeMode,

            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorSchemeSeed: Colors.cyan,
            ),

            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xff050505),

              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.cyanAccent,
                brightness: Brightness.dark,
              ),

              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
              ),
            ),

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
