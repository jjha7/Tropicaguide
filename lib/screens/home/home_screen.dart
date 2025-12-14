import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../store/trip_store.dart';
import '../../theme/app_colors.dart';
import '../trip/trip_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final store = context.watch<TripStore>();
    store.seedIfEmpty();

    return Scaffold(
      appBar: AppBar(title: const Text('TropicaGuide')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
        children: [
          Text('Your trips', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          ...store.trips.map(
            (trip) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TripDetailScreen(tripId: trip.id)),
                ),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(trip.imagePath, fit: BoxFit.cover),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [Colors.black87, Colors.transparent],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Text(
                                trip.title,
                                style: t.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                trip.location,
                                style: t.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${trip.startDate.month}/${trip.startDate.day} to ${trip.endDate.month}/${trip.endDate.day}',
                                style: t.textTheme.bodySmall?.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
