import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/main.dart';

void main() {
  testWidgets('uses system brightness and allows toggling it', (tester) async {
    SharedPreferences.setMockInitialValues({
      'genoves_user_profile': 'student',
    });

    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    expect(
      tester.widget<HomePage>(find.byType(HomePage)).useLightMode,
      isFalse,
    );

    await tester.tap(find.byTooltip('Alterar tema'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<HomePage>(find.byType(HomePage)).useLightMode,
      isTrue,
    );

    await tester.tap(find.byTooltip('Alterar tema'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<HomePage>(find.byType(HomePage)).useLightMode,
      isFalse,
    );
  });
}