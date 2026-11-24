import 'package:flutter_test/flutter_test.dart';
import 'package:cv_flutter_miriam/main.dart';

void main() {
  testWidgets('App se lance', (tester) async {
    await tester.pumpWidget(const MonCvApp());
    expect(find.text('Connexion cv Miriam'), findsOneWidget);
  });
}
