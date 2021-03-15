// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/app.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/models/post_dto.dart';

void main() {
  test('Post created from intantiation should have appropriate property values',
      () {
    final date = Timestamp.fromDate(DateTime.parse('2021-03-03'));
    final url = 'FAKE';
    const numWasted = 1;
    const latitude = 1.0;
    const longitude = 1.0;

    final food_post = FoodWastePost(
        date: date,
        imgUrl: url,
        numWasted: numWasted,
        latitude: latitude,
        longitude: longitude);

    expect(food_post.date, date);
    expect(food_post.imgUrl, url);
    expect(food_post.numWasted, numWasted);
    expect(food_post.latitude, latitude);
    expect(food_post.longitude, longitude);
  });
  test('Post converted to map should have appropriate property values', () {
    final date = Timestamp.fromDate(DateTime.parse('2021-03-03'));
    final url = 'FAKE';
    const numWasted = 1;
    const latitude = 1.0;
    const longitude = 1.0;

    final expected_post_map = {
      'date': date,
      'image_url': url,
      'num_wasted': numWasted,
      'latitude': latitude,
      'longitude': longitude
    };
    final food_post = FoodWastePost(
        date: date,
        imgUrl: url,
        numWasted: numWasted,
        latitude: latitude,
        longitude: longitude);

    final map_from_post = food_post.toMap();

    expect(expected_post_map['date'], map_from_post['date']);
    expect(expected_post_map['image_url'], map_from_post['image_url']);
    expect(expected_post_map['num_wasted'], map_from_post['num_wasted']);
    expect(expected_post_map['latitude'], map_from_post['latitude']);
    expect(expected_post_map['longitude'], map_from_post['longitude']);
  });

  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(App());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}
