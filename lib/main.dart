import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'store/trip_store.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TripStore(),
      child: const TropicaGuideApp(),
    ),
  );
}
