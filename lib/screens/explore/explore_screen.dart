import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    final items = const [
      _ExploreItem('Street food tour', 'Great for first night', 'assets/images/tokyo.jpg'),
      _ExploreItem('City skyline photo walk', 'Golden hour vibes', 'assets/images/nyc.jpg'),
      _ExploreItem('Snow hike + cafe', 'Easy and scenic', 'assets/images/manali.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text('Popular right now', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          ...items.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ExploreCard(item: e),
              )),
        ],
      ),
    );
  }
}

class _ExploreItem {
  final String title;
  final String subtitle;
  final String image;
  const _ExploreItem(this.title, this.subtitle, this.image);
}

class _ExploreCard extends StatelessWidget {
  final _ExploreItem item;
  const _ExploreCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);

    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item.image, fit: BoxFit.cover),
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
                    item.title,
                    style: t.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: t.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
