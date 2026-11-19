import 'package:flutter/material.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  void _showComingSoon(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$section estará disponível em breve.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Área de Estudos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          tooltip: 'Voltar',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              Text(
                'Sua jornada de conhecimento',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
              ),

              const SizedBox(height: 8),

              Text(
                'Escolha por onde deseja começar.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 28),

              _StudyCard(
                icon: Icons.menu_book_outlined,
                title: 'Disciplinas',
                description: 'Explore conteúdos de aprendizagem.',
                color: colorScheme.primary,
                onTap: () => _showComingSoon(context, 'Disciplinas'),
              ),

              _StudyCard(
                icon: Icons.flag_outlined,
                title: 'Missões',
                description: 'Encare desafios e novas atividades.',
                color: AppThemeColors.gold,
                onTap: () => _showComingSoon(context, 'Missões'),
              ),

              _StudyCard(
                icon: Icons.psychology_outlined,
                title: 'Quizzes',
                description: 'Pratique e teste seus conhecimentos.',
                color: colorScheme.primary,
                onTap: () => _showComingSoon(context, 'Quizzes'),
              ),

              _StudyCard(
                icon: Icons.trending_up,
                title: 'Meu progresso',
                description: 'Acompanhe sua evolução nos estudos.',
                color: AppThemeColors.gold,
                onTap: () => _showComingSoon(context, 'Meu progresso'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudyCard extends StatelessWidget {
  const _StudyCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(description),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class AppThemeColors {
  static const Color gold = Color(0xFFD4AF37);
}