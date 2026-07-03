import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmerx/shimmerx.dart';

void main() {
  testWidgets('Shimmer with gradient renders child', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Shimmer(
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.white],
          ),
          child: const Text('Loading'),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
  });

  testWidgets('Widget.shimmer extension renders child', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const Text('Loading').shimmer(),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    expect(find.byType(Shimmer), findsOneWidget);
  });

  testWidgets('Widget.shimmer works on Container and Card', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              color: Colors.grey,
            ).shimmer(),
            Card(
              child: SizedBox(height: 80, child: Center(child: Text('Card'))),
            ).shimmer(),
          ],
        ),
      ),
    );

    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(Shimmer), findsNWidgets(2));
  });

  testWidgets('ShimmerTheme provides theme data', (WidgetTester tester) async {
    await tester.pumpWidget(
      ShimmerTheme(
        data: const ShimmerThemeData(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.white],
          ),
        ),
        child: MaterialApp(
          home: Scaffold(
            body: Shimmer.themed(
              child: const Text('Loading'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    expect(find.byType(Shimmer), findsOneWidget);
  });

  testWidgets('ShimmerPreset returns valid theme data', (WidgetTester tester) async {
    final youtubeTheme = ShimmerPreset.youtube();
    expect(youtubeTheme, isA<ShimmerThemeData>());
    expect(youtubeTheme.gradient, isA<LinearGradient>());
  });

  testWidgets('ShimmerController can control animation', (WidgetTester tester) async {
    final controller = ShimmerController();
    
    await tester.pumpWidget(
      MaterialApp(
        home: Shimmer(
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.white],
          ),
          controller: controller,
          child: const Text('Loading'),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    
    controller.pause();
    controller.resume();
    controller.dispose();
  });
}
