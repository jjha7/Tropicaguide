import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TripShellScreen extends StatefulWidget {
  static const route = '/trip';
  const TripShellScreen({super.key});

  @override
  State<TripShellScreen> createState() => _TripShellScreenState();
}

class _TripShellScreenState extends State<TripShellScreen> {
  int index = 0;

  final pages = const [
    _StubPage(title: 'Itinerary', subtitle: 'Day by day plan UI goes here'),
    _StubPage(title: 'Packing', subtitle: 'Shared packing list UI goes here'),
    _StubPage(title: 'Checklist', subtitle: 'Docs and essentials UI goes here'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tokyo Spring Plan'),
        backgroundColor: AppColors.bg,
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Itinerary'),
          NavigationDestination(icon: Icon(Icons.backpack), label: 'Packing'),
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Checklist'),
        ],
      ),
    );
  }
}

class _StubPage extends StatelessWidget {
  final String title;
  final String subtitle;
  const _StubPage({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(subtitle, style: t.textTheme.bodyMedium?.copyWith(color: AppColors.subtext)),
            const SizedBox(height: 14),
            Text(
              'Milestone 1 target: polished UI and navigation. Firebase sync comes next.',
              style: t.textTheme.bodySmall?.copyWith(color: AppColors.subtext),
            ),
          ],
        ),
      ),
    );
  }
}
