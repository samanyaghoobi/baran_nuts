// ببین یک تمم رو میخواهم کرمی تر کنی 
// سیاه سفید باشه 
// ولی سفیدش کرمی تر خیلی خفیف
import 'package:flutter/material.dart';

class AppTheme {
  // Brand color intentionally set to black for a monochrome look
  static const Color _brand = Colors.black;

  static ThemeData light() {
    // Start from a neutral seed, then force key roles to pure B/W
    final base = ColorScheme.fromSeed(
      seedColor: _brand,
      brightness: Brightness.light,
    );

    // Grayscale overrides to keep UI truly black & white (with subtle greys)
    final scheme = base.copyWith(
      primary: Colors.black,
      onPrimary: Colors.white,
      primaryContainer: Colors.white,
      onPrimaryContainer: Colors.black,

      secondary: Colors.black,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFF3F3F3),
      onSecondaryContainer: Colors.black,

      surface: Colors.white,
      onSurface: Colors.black,
      surfaceTint: Colors.transparent, // remove color cast on surfaces

      background: Colors.white,
      onBackground: Colors.black,

      outline: const Color(0xFFDDDDDD),
      outlineVariant: const Color(0xFFE9E9E9),

      // These are Material 3 containers used by some components
      surfaceContainerHighest: const Color(0xFFF7F7F7),
      surfaceContainerHigh: const Color(0xFFF9F9F9),
      surfaceContainer: const Color(0xFFFAFAFA),
      surfaceContainerLow: const Color(0xFFFBFBFB),
      surfaceContainerLowest: const Color(0xFFFCFCFC),

      // Keep error colors standard for accessibility
      error: const Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF410002),
    );

    const radius = 14.0;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,

      // Typography: neutral weights + better paragraph leading for Farsi
      typography: Typography.material2021(),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: FontWeight.w600),
        displayMedium: TextStyle(fontWeight: FontWeight.w600),
        displaySmall: TextStyle(fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(height: 1.5),
        bodyMedium: TextStyle(height: 1.5),
        bodySmall: TextStyle(height: 1.5),
        labelLarge: TextStyle(fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontWeight: FontWeight.w600),
      ),

      // AppBar: white background, black content
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(color: scheme.onSurface),
      ),

      // Cards: white surface, soft radius, subtle shadow
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),

      // Buttons — keep them strictly monochrome
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.black),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.black),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.black),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          side: WidgetStateProperty.resolveWith((states) {
            final color = states.contains(WidgetState.disabled)
                ? scheme.outlineVariant
                : Colors.black;
            return BorderSide(color: color, width: 1);
          }),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.black),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),

      // Inputs: white fill, gray borders, black focus
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),

      // ListTiles: neutral colors, rounded shape
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        selectedColor: Colors.black,
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
      ),

      // Icons and Dividers
      iconTheme: IconThemeData(color: scheme.onSurface),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 24,
      ),

      // Chips: grey background, black text
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: scheme.outlineVariant),
        selectedColor: scheme.surfaceContainer,
        backgroundColor: scheme.surfaceContainerLowest,
        labelStyle: TextStyle(color: scheme.onSurface),
      ),

      // Scrollbar: visible + neutral thumb
      scrollbarTheme: ScrollbarThemeData(
        thickness: WidgetStateProperty.all(8),
        radius: const Radius.circular(12),
        thumbVisibility: WidgetStateProperty.all(true),
        thumbColor: WidgetStateProperty.all(Colors.black45),
      ),

      // Progress indicators in black
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.black,
      ),

      // BottomSheet & Dialogs: white surfaces with rounded corners
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

// ???
//  dialogTheme: DialogThemeData(
//         backgroundColor: scheme.surface,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(radius),
//         ),
//       ),

     // Cards: white surface, soft radius, subtle shadow
      // cardTheme: CardThemeData(
      //   color: scheme.surface,
      //   elevation: 2,
      //   margin: EdgeInsets.zero,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(radius),
      //   ),
      // ),