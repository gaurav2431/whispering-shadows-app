import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  runApp(const WhisperingShadowsApp());
}

class WhisperingShadowsApp extends StatelessWidget {
  const WhisperingShadowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseService>(
          create: (_) => FirebaseService(),
        ),
      ],
      child: MaterialApp(
        title: 'Whispering Shadows',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Dark mystical theme
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF6A0DAD), // Deep purple
          scaffoldBackgroundColor: const Color(0xFF0D0221), // Very dark purple
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF6A0DAD),
            secondary: const Color(0xFF9D4EDD), // Light purple
            surface: const Color(0xFF1A0B2E),
            background: const Color(0xFF0D0221),
          ),
          
          // Custom text theme with mystical fonts
          textTheme: GoogleFonts.cinzelTextTheme(
            ThemeData.dark().textTheme,
          ).copyWith(
            headlineLarge: GoogleFonts.cinzel(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF9D4EDD),
            ),
            headlineMedium: GoogleFonts.cinzel(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            bodyLarge: GoogleFonts.crimsonText(
              fontSize: 18,
              color: Colors.white70,
            ),
            bodyMedium: GoogleFonts.crimsonText(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
          
          // Card theme for tarot cards
          cardTheme: CardTheme(
            color: const Color(0xFF1A0B2E),
            elevation: 8,
            shadowColor: const Color(0xFF6A0DAD).withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          
          // Button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A0DAD),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
          ),
          
          // Input decoration theme
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFF1A0B2E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6A0DAD)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6A0DAD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF9D4EDD), width: 2),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}