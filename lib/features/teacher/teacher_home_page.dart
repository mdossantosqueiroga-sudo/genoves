import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Área do Professor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          tooltip: 'Sair',
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
              Center(
                child: Image.asset(
                  'assets/images/genoves_logo.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bem-vindo à área do professor!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.oliveGreen,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aqui você poderá organizar atividades e acompanhar '
                'a aprendizagem dos estudantes.',
              ),
              const SizedBox(height: 28),
              _TeacherCard(
                icon: Icons.quiz_outlined,
                title: 'Criar quizzes',
                description: 'Prepare desafios de aprendizagem.',
              ),
              _TeacherCard(
                icon: Icons.poll_outlined,
                title: 'Criar enquetes',
                description: 'Consulte a opinião da turma.',
              ),
              _TeacherCard(
                icon: Icons.groups_outlined,
                title: 'Minhas turmas',
                description: 'Organize suas turmas e estudantes.',
              ),
              _TeacherCard(
                icon: Icons.analytics_outlined,
                title: 'Acompanhar aprendizagem',
                description: 'Visualize o progresso dos estudantes.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Versão demonstrativa: as ferramentas ainda dependem '
                'de autorização e integração.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  const _TeacherCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppTheme.gold.withValues(alpha: 0.18),
          child: Icon(icon, color: AppTheme.oliveGreen),
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
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title estará disponível em breve.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }
}