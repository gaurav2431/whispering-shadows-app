import 'package:flutter/material.dart';
import 'tarot_screen.dart';
import 'ghost_chat_screen.dart';
import 'history_screen.dart';

/// Main home screen with navigation to different features
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0D0221),
              const Color(0xFF1A0B2E),
              const Color(0xFF0D0221),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App title with mystical styling
                Text(
                  'Whispering',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Shadows',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 48,
                        letterSpacing: 4,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '✦ Beyond the Veil ✦',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF9D4EDD),
                      ),
                ),
                const SizedBox(height: 60),

                // Tarot Reading Button
                _MenuCard(
                  icon: Icons.auto_awesome,
                  title: 'Tarot Reading',
                  subtitle: 'Unveil the cards of fate',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TarotScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Ghost Chat Button
                _MenuCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Ghost Chat',
                  subtitle: 'Speak with the spirits',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GhostChatScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Reading History Button
                _MenuCard(
                  icon: Icons.history,
                  title: 'Past Readings',
                  subtitle: 'Revisit the shadows',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),

                const Spacer(),

                // Footer text
                Text(
                  '*whispers in the darkness*',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.white30,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable menu card widget
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6A0DAD).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF9D4EDD),
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white54,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF9D4EDD),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}