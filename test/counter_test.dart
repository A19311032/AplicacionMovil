import 'package:flutter_test/flutter_test.dart';
import 'package:aplicacion_movil2/main.dart';


void main() {
  testWidgets('Test de la pantalla de login', (WidgetTester tester) async {
    // Construir la app
    await tester.pumpWidget(const MyApp());

    // Buscar un widget específico, como un botón
    expect(find.text('Entrar'), findsOneWidget);

    // Interactuar con el widget (si es necesario)
    await tester.pump();

    // Comprobar los resultados
    expect(find.text('Usuario o contraseña incorrectos'), findsOneWidget);
  });
}
