import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

import '../../store/trip_store.dart';
import '../../theme/app_colors.dart';

class TripDetailScreen extends StatefulWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> with TickerProviderStateMixin {
  late final TabController controller;
  final chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    chatController.dispose();
    super.dispose();
  }

  Future<void> _pickTicketPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: false,
    );

    if (result == null) return;
    final file = result.files.first;

    if (file.path == null) return;

    context.read<TripStore>().addFileToTrip(
          tripId: widget.tripId,
          fileName: file.name,
          path: file.path!,
        );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TripStore>();
    final trip = store.getTripById(widget.tripId);

    if (trip == null) {
      return const Scaffold(body: Center(child: Text('Trip not found')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(trip.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  Image.asset(
                    trip.imagePath,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.location,
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${trip.startDate.month}/${trip.startDate.day}/${trip.startDate.year} to ${trip.endDate.month}/${trip.endDate.day}/${trip.endDate.year}',
                          style: const TextStyle(color: AppColors.subtext),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: TabBar(
                controller: controller,
                labelColor: AppColors.text,
                unselectedLabelColor: AppColors.subtext,
                indicator: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(16),
                ),
                indicatorPadding: const EdgeInsets.all(6),
                tabs: const [
                  Tab(text: 'Itinerary'),
                  Tab(text: 'Packing'),
                  Tab(text: 'Checklist'),
                  Tab(text: 'Members'),
                  Tab(text: 'Files'),
                  Tab(text: 'Chat'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                _PlaceholderTab(title: 'Itinerary', subtitle: 'Add time blocks and plans'),
                _PlaceholderTab(title: 'Packing', subtitle: 'Track what is packed'),
                _PlaceholderTab(title: 'Checklist', subtitle: 'Passport, insurance, etc'),
                _MembersTab(tripId: widget.tripId),
                _FilesTab(tripId: widget.tripId, onUpload: () => _pickTicketPdf(context)),
                _ChatTab(tripId: widget.tripId, controller: chatController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PlaceholderTab({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.auto_awesome_rounded),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AppColors.subtext)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MembersTab extends StatelessWidget {
  final String tripId;

  const _MembersTab({required this.tripId});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TripStore>();
    final trip = store.getTripById(tripId)!;

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Trip members',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showModalBottomSheet<String>(
                    context: context,
                    backgroundColor: AppColors.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    builder: (ctx) {
                      return Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Add traveler', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                            const SizedBox(height: 12),
                            ...store.travelers.map((t) {
                              final already = trip.travelers.any((m) => m.id == t.id);
                              return ListTile(
                                title: Text(t.name),
                                subtitle: Text(t.role),
                                trailing: already ? const Text('Added') : const Icon(Icons.add_rounded),
                                onTap: already ? null : () => Navigator.pop(ctx, t.id),
                              );
                            }),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );

                  if (picked == null) return;
                  final traveler = store.travelers.firstWhere((x) => x.id == picked);
                  context.read<TripStore>().addTravelerToTrip(tripId: tripId, traveler: traveler);
                },
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: trip.travelers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (ctx, i) {
                final m = trip.travelers[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.group_rounded),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                            const SizedBox(height: 2),
                            Text(m.role, style: const TextStyle(color: AppColors.subtext)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilesTab extends StatelessWidget {
  final String tripId;
  final VoidCallback onUpload;

  const _FilesTab({required this.tripId, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TripStore>();
    final trip = store.getTripById(tripId)!;

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tickets and documents',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              ElevatedButton(
                onPressed: onUpload,
                child: const Text('Upload PDF'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: trip.files.isEmpty
                ? const _EmptyState(
                    title: 'No files yet',
                    subtitle: 'Upload flight tickets, hotel confirmations, QR codes as PDFs',
                  )
                : ListView.separated(
                    itemCount: trip.files.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final f = trip.files[i];
                      return InkWell(
                        onTap: () => OpenFilex.open(f.path),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.16),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.picture_as_pdf_rounded),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      f.name,
                                      style: const TextStyle(fontWeight: FontWeight.w900),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Tap to open',
                                      style: const TextStyle(color: AppColors.subtext),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right_rounded),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ChatTab extends StatelessWidget {
  final String tripId;
  final TextEditingController controller;

  const _ChatTab({required this.tripId, required this.controller});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TripStore>();
    final trip = store.getTripById(tripId)!;

    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Expanded(
            child: trip.messages.isEmpty
                ? const _EmptyState(
                    title: 'No messages yet',
                    subtitle: 'Use chat to coordinate plans and share quick updates',
                  )
                : ListView.separated(
                    itemCount: trip.messages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (ctx, i) {
                      final m = trip.messages[i];
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m.senderName, style: const TextStyle(fontWeight: FontWeight.w900)),
                            const SizedBox(height: 6),
                            Text(m.text),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: 'Message'),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<TripStore>().sendMessage(
                          tripId: tripId,
                          senderName: 'Jigyasa',
                          text: controller.text,
                        );
                    controller.clear();
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: AppColors.subtext), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
