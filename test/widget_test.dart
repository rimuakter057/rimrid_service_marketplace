import 'package:flutter_test/flutter_test.dart';

import 'package:rimrid_service_marketplace/main.dart';

void main() {
  testWidgets('App boots to the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const RimridApp());
    await tester.pump();

    expect(find.text('Rimrid'), findsOneWidget);
  });
}
