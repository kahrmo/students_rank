import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o App'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.filter_hdr_rounded,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'PiramidGame IFPR-Pgua',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Versão 1.0.0',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildAboutCard(
              context,
              icon: Icons.track_changes_rounded,
              title: 'Objetivo do Aplicativo',
              description: 'O PiramidGame é uma aplicação mobile destinada ao cadastro, avaliação e ranqueamento dos alunos do IFPR – Campus Paranaguá.',
            ),
            const SizedBox(height: 16),
            _buildAboutCard(
              context,
              icon: Icons.emoji_events_rounded,
              title: 'Funcionamento do Ranking',
              description: 'Os alunos são listados de forma decrescente com base no seu Nível Lenda. Os três primeiros colocados recebem destaque visual (ouro, prata e bronze) no pódio de popularidade do campus!',
            ),
            const SizedBox(height: 16),
            _buildAboutCard(
              context,
              icon: Icons.bolt_rounded,
              title: 'Explicação do Nível Lenda',
              description: 'O Nível Lenda é a soma das notas atribuídas aos 15 critérios de popularidade (como Carisma, Aura, Humor, etc.). Cada critério vale de 1 a 5 estrelas. A pontuação mínima é 15 e a máxima é 75. O cálculo ocorre de forma reativa e automática.',
            ),
            const SizedBox(height: 16),
            _buildAboutCard(
              context,
              icon: Icons.storage_rounded,
              title: 'Armazenamento Local',
              description: 'Todos os seus dados são salvos de forma 100% segura e privada diretamente no dispositivo utilizando o SharedPreferences em formato JSON. Suas informações não saem do aparelho.',
            ),
            const SizedBox(height: 16),
            _buildAboutCard(
              context,
              icon: Icons.dark_mode_rounded,
              title: 'Temas Claro & Escuro',
              description: 'Você pode alternar entre o tema claro e o tema escuro em tempo real. A preferência de tema é persistida automaticamente para a sua próxima sessão.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
