import 'package:flutter/material.dart';


import '../../app/theme/app_theme.dart';

class ProfileSelectionPage extends StatelessWidget {
  const ProfileSelectionPage({
    super.key,
    required this.onProfileSelected,
  });

  final Future<void> Function(String profile) onProfileSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/genoves_logo.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 24),
                Text(
                  'Bem-vindo ao Genovês!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.oliveGreen,
                      ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Para começar, escolha seu perfil.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _ProfileButton(
                  icon: Icons.school_outlined,
                  title: 'Sou aluno',
                  description: 'Quero aprender e cumprir missões.',
                  onTap: () => onProfileSelected('student'),
                ),
                const SizedBox(height: 16),
                _ProfileButton(
                  icon: Icons.cast_for_education_outlined,
                  title: 'Sou professor',
                  description: 'Quero acompanhar e orientar alunos.',
                  onTap: () => onProfileSelected('teacher'),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Do primeiro aprendizado ao pensamento crítico',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.oliveGreen,
                    fontWeight: FontWeight.w600,
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

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: AppTheme.oliveGreen,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(description),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}