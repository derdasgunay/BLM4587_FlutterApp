import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/main.dart';

void main() {
  testWidgets('Kurulum ekranı metnini gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(
      find.textContaining('Flutter ve Dart kurulumları tamamlandı'),
      findsOneWidget,
    );
  });
}
