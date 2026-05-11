import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ola_mundo/main.dart';

void main() {
  testWidgets('Digitar "ola" mostra "olá mundo"', (tester) async {
    await tester.pumpWidget(const OlaMundoApp());

    expect(find.text('olá mundo'), findsNothing);

    await tester.enterText(find.byType(TextField), 'ola');
    await tester.pump();

    expect(find.text('olá mundo'), findsOneWidget);
  });

  testWidgets('Aceita "Olá" com acento e maiúscula', (tester) async {
    await tester.pumpWidget(const OlaMundoApp());

    await tester.enterText(find.byType(TextField), 'Olá');
    await tester.pump();

    expect(find.text('olá mundo'), findsOneWidget);
  });

  testWidgets('Texto diferente não dispara resposta', (tester) async {
    await tester.pumpWidget(const OlaMundoApp());

    await tester.enterText(find.byType(TextField), 'tchau');
    await tester.pump();

    expect(find.text('olá mundo'), findsNothing);
  });
}
