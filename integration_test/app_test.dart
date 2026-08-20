import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:member_attendance/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify attendance marking flow', (tester) async {
      // Start the app
      await app.main();
      await tester.pumpAndSettle();

      // Wait for data to load (simulating network delay)
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Find "Send OTP" button for the first MP and tap it
      final sendOtpButton = find.text('Send OTP').first;
      expect(sendOtpButton, findsOneWidget);
      await tester.tap(sendOtpButton);
      await tester.pumpAndSettle();

      // Verify OTP dialog is shown
      expect(find.text('OTP Verification'), findsOneWidget);

      // Enter OTP '1234'
      await tester.enterText(find.byType(TextField), '1234');
      await tester.pumpAndSettle();

      // Tap "Verify OTP" button
      final verifyButton = find.text('Verify OTP');
      await tester.tap(verifyButton);
      await tester.pumpAndSettle();

      // Verify success dialog
      expect(find.text('Attendance Marked!'), findsOneWidget);

      // Close success dialog
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      // Verify success dialog is gone
      expect(find.text('Attendance Marked!'), findsNothing);
    });
  });
}
