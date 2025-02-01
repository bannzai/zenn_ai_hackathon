import 'package:flutter/material.dart';
import 'package:todomaker/features/root/page.dart';
import 'package:todomaker/style/color.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    );

    return MaterialApp(
      theme: ThemeData(
        colorScheme: colorScheme,
        dividerColor: Colors.black,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.formBackground,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 1,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.primary,
            textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            minimumSize: const Size(double.infinity, 48.0),
            textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            disabledBackgroundColor: AppColors.disabled,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedTextStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(),
          ),
        ),
        useMaterial3: false,
      ),
      home: const RootPage(),
    );
  }
}
