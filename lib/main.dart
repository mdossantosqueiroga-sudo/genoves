import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/theme/app_theme.dart';
import 'features/profile/profile_selection_page.dart';
import 'features/student/student_home_page.dart';
import 'features/teacher/teacher_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _profileKey = 'genoves_user_profile';

  ThemeMode _themeMode = ThemeMode.system;
  String? _selectedProfile;
  bool _isLoading = true;

  bool get useLightMode {
    switch (_themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final savedProfile = prefs.getString(_profileKey);

    if (!mounted) return;

    setState(() {
      _selectedProfile = savedProfile;
      _isLoading = false;
    });
  }

  Future<void> _saveProfile(String profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, profile);

    if (!mounted) return;

    setState(() {
      _selectedProfile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genovês',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_selectedProfile == null) {
      return ProfileSelectionPage(
        onProfileSelected: _saveProfile,
      );
    }

    if (_selectedProfile == 'student') {
      return HomePage(
        useLightMode: useLightMode,
        onBrightnessChanged: _changeBrightness,
      );
    }

    if (_selectedProfile == 'teacher') {
      return const TeacherHomePage();
    }

    return ProfileSelectionPage(
      onProfileSelected: _saveProfile,
    );
  }

  void _changeBrightness(bool isLight) {
    setState(() {
      _themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.useLightMode,
    required this.onBrightnessChanged,
  });

  final bool useLightMode;
  final ValueChanged<bool> onBrightnessChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/genoves_logo.png',
              width: 42,
              height: 42,
            ),
            const SizedBox(width: 10),
            const Text(
              'Genovês',
              style: TextStyle(
                color: AppTheme.oliveGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Alterar tema',
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            onPressed: () => onBrightnessChanged(
              Theme.of(context).brightness != Brightness.light,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Image.asset(
                'assets/images/genoves_logo.png',
                width: 170,
                height: 170,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                'Do primeiro aprendizado ao pensamento crítico',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                'Seu conhecimento começa aqui.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Aprenda, explore e cumpra novas missões.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 35),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Continue aprendendo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Retome seus estudos de onde parou.',
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StudentHomePage(),
                              ),
                            );
                          },
                          child: const Text('Acessar estudos'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: colorScheme.primary),
                  Icon(Icons.flag, color: colorScheme.primary),
                  Icon(Icons.person, color: colorScheme.primary),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}