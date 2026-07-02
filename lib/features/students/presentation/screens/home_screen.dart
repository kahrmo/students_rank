import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../viewmodels/theme_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  final ThemeViewModel themeViewModel;

  const HomeScreen({super.key, required this.themeViewModel});

  @override
  Widget build(BuildContext context) {
    final isDark = themeViewModel.isDarkMode.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PiramidGame IFPR'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: () {
              themeViewModel.toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Bem-vindo ao PiramidGame!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Gerencie alunos, atribua notas de popularidade e confira o Ranking Geral do Campus Paranaguá.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _MenuCard(
                      title: 'Alunos',
                      subtitle: 'Gerenciar alunos',
                      icon: Icons.people_alt_rounded,
                      color: Colors.indigo,
                      onTap: () => context.push('/students'),
                    ),
                    _MenuCard(
                      title: 'Ranking',
                      subtitle: 'Ver classificação',
                      icon: Icons.emoji_events_rounded,
                      color: Colors.amber.shade700,
                      onTap: () => context.push('/ranking'),
                    ),
                    _MenuCard(
                      title: 'Sobre',
                      subtitle: 'Como funciona',
                      icon: Icons.info_outline_rounded,
                      color: Colors.teal,
                      onTap: () => context.push('/about'),
                    ),
                    _MenuCard(
                      title: isDark ? 'Tema Claro' : 'Tema Escuro',
                      subtitle: 'Alternar tema',
                      icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: Colors.purple,
                      onTap: () => themeViewModel.toggleTheme(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.85),
                color.withOpacity(0.6),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
