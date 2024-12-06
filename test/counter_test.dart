// test/counter_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_proyecto/main.dart'; // Asegúrate de poner el nombre correcto

void main() {
  testWidgets('Contador se incrementa al presionar el botón', (WidgetTester tester) async {
    // Construir el widget
    await tester.pumpWidget(MyApp());

    // Verificar que el contador empieza en 0
    expect(find.text('Contador: 0'), findsOneWidget);

    // Tocar el botón y actualizar el widget
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verificar que el contador se ha incrementado
    expect(find.text('Contador: 1'), findsOneWidget);
  });
}
