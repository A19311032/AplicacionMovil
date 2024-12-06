import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aplicacion_movil2/main.dart';


void main() {
  testWidgets('El contador comienza en 0 y se incrementa al presionar el botón', (WidgetTester tester) async {
    // Carga el widget
    await tester.pumpWidget(MyApp());

    // Verifica que el contador comienza en 0
    expect(find.text('Contador: 0'), findsOneWidget);

    // Encuentra el botón y simula un clic
    await tester.tap(find.byType(ElevatedButton));

    // Espera a que el widget se actualice
    await tester.pump();

    // Verifica que el contador ha incrementado a 1
    expect(find.text('Contador: 1'), findsOneWidget);
  });
}

