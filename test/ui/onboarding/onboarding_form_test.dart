import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_album/ui/onboarding/onboarding_form.dart';

void main() {
  late Widget sut;
  String? actualUsername;
  String? actualPassword;

  setUp(() {
    actualUsername = null;
    actualPassword = null;

    void submitCallback({required String username, required String password}) {
      actualUsername = username;
      actualPassword = password;
    }

    sut = OnboardingForm(submitCallback: submitCallback);
  });

  testWidgets(
      'When username and password is saved, Then submit callback is called',
      (WidgetTester tester) async {
    var expectedUsername = 'abc';
    var expectedPassword = '123';
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: sut)));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      expectedUsername,
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      expectedPassword,
    );
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(actualUsername, expectedUsername);
    expect(actualPassword, expectedPassword);
    expect(find.text('Should not be blank.'), findsNothing);
  });

  testWidgets(
      'When username is omitted and saved, '
      'Then error is shown and submit callback is not called',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: sut)));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'pass',
    );
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(actualUsername, null);
    expect(actualPassword, null);
    expect(find.text('Should not be blank.'), findsOneWidget);
  });

  testWidgets(
      'When password is blank and saved, '
      'Then error is shown and submit callback is not called',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: sut)));

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Username'),
      'user',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      '  ',
    );
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(actualUsername, null);
    expect(actualPassword, null);
    expect(find.text('Should not be blank.'), findsOneWidget);
  });
}
