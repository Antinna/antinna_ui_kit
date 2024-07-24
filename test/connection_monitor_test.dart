// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:antinna_ui_kit/antinna_ui_kit.dart';

// void main() {
//   testWidgets('ConnectivityBannerHost renders correctly with initial state',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: ConnectivityBannerHost(
//             isConnected: true,
//             banner:
//                 Container(key: Key('banner'), height: 50.0, color: Colors.red),
//             child:
//                 Container(key: Key('child'), height: 100.0, color: Colors.blue),
//           ),
//         ),
//       ),
//     );

//     // Verify that the banner and child widgets are present
//     expect(find.byKey(Key('banner')), findsOneWidget);
//     expect(find.byKey(Key('child')), findsOneWidget);

//     // Verify the banner's height and color
//     final bannerWidget = tester.widget<Container>(find.byKey(Key('banner')));
//     // expect(bannerWidget.height, 50.0);
//     expect(bannerWidget.color, Colors.red);

//     // Verify the child's height and color
//     final childWidget = tester.widget<Container>(find.byKey(Key('child')));
//     // expect(childWidget.constraints, 100.0);
//     expect(childWidget.color, Colors.blue);
//   });

//   testWidgets(
//       'ConnectivityBannerHost animates correctly when isConnected changes',
//       (WidgetTester tester) async {
//     // Build the widget with isConnected false
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: ConnectivityBannerHost(
//             isConnected: false,
//             banner:
//                 Container(key: Key('banner'), height: 50.0, color: Colors.red),
//             child:
//                 Container(key: Key('child'), height: 100.0, color: Colors.blue),
//           ),
//         ),
//       ),
//     );

//     // Verify the initial state
//     expect(find.byKey(Key('banner')), findsOneWidget);
//     expect(find.byKey(Key('child')), findsOneWidget);

//     // Rebuild the widget with isConnected true
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: ConnectivityBannerHost(
//             isConnected: true,
//             banner:
//                 Container(key: Key('banner'), height: 50.0, color: Colors.red),
//             child:
//                 Container(key: Key('child'), height: 100.0, color: Colors.blue),
//           ),
//         ),
//       ),
//     );

//     // Ensure the widget tree is rebuilt
//     await tester.pump(); // to ensure animation frame updates
//     await tester.pump(
//         const Duration(milliseconds: 300)); // to simulate the end of animation

//     // Verify that the banner is positioned correctly
//     final bannerFinder = find.byKey(Key('banner'));
//     final bannerSize = tester.getSize(bannerFinder);

//     expect(bannerSize.height, 50.0);
//   });
// }
