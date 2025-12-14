import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Traveler {
  final String id;
  final String name;
  final String role;

  Traveler({
    required this.id,
    required this.name,
    required this.role,
  });
}

class TripFile {
  final String id;
  final String name;
  final String path;
  final DateTime addedAt;

  TripFile({
    required this.id,
    required this.name,
    required this.path,
    required this.addedAt,
  });
}

class ChatMessage {
  final String id;
  final String senderName;
  final String text;
  final DateTime sentAt;

  ChatMessage({
    required this.id,
    required this.senderName,
    required this.text,
    required this.sentAt,
  });
}

class TripPlanItem {
  final String id;
  final TimeOfDay time;
  final String title;
  final String subtitle;

  TripPlanItem({
    required this.id,
    required this.time,
    required this.title,
    required this.subtitle,
  });
}

class Trip {
  final String id;
  String title;
  String location;
  DateTime startDate;
  DateTime endDate;
  String imagePath;

  final List<TripPlanItem> itinerary;
  final List<String> checklist;
  final List<String> packing;
  final List<Traveler> travelers;
  final List<TripFile> files;
  final List<ChatMessage> messages;

  Trip({
    required this.id,
    required this.title,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.imagePath,
    required this.itinerary,
    required this.checklist,
    required this.packing,
    required this.travelers,
    required this.files,
    required this.messages,
  });
}

class TripStore extends ChangeNotifier {
  final List<Trip> _trips = [];

  List<Trip> get trips => _trips;

  List<Traveler> get travelers {
    final all = <Traveler>[];
    for (final trip in _trips) {
      all.addAll(trip.travelers);
    }
    final seen = <String>{};
    final unique = <Traveler>[];
    for (final t in all) {
      if (seen.add(t.id)) unique.add(t);
    }
    return unique;
  }

  void seedIfEmpty() {
    if (_trips.isNotEmpty) return;

    _trips.addAll([
      Trip(
        id: _uuid.v4(),
        title: 'Tokyo Spring Plan',
        location: 'Tokyo, Japan',
        startDate: DateTime(2026, 3, 12),
        endDate: DateTime(2026, 3, 18),
        imagePath: 'assets/images/tokyo.jpg',
        itinerary: [
          TripPlanItem(
            id: _uuid.v4(),
            time: const TimeOfDay(hour: 15, minute: 0),
            title: 'Arrive and check in',
            subtitle: 'Hotel near Shinjuku',
          ),
          TripPlanItem(
            id: _uuid.v4(),
            time: const TimeOfDay(hour: 19, minute: 30),
            title: 'Night food walk',
            subtitle: 'Try ramen, taiyaki',
          ),
        ],
        checklist: ['Passport', 'Visa docs', 'Travel insurance'],
        packing: ['Jacket', 'Sneakers', 'Power adapter'],
        travelers: [
          Traveler(id: _uuid.v4(), name: 'Jigyasa', role: 'Owner'),
        ],
        files: [],
        messages: [],
      ),
      Trip(
        id: _uuid.v4(),
        title: 'Weekend In NYC',
        location: 'New York City, USA',
        startDate: DateTime(2026, 1, 10),
        endDate: DateTime(2026, 1, 12),
        imagePath: 'assets/images/nyc.jpg',
        itinerary: [],
        checklist: ['ID', 'Hotel confirmation'],
        packing: ['Coat', 'Scarf'],
        travelers: [
          Traveler(id: _uuid.v4(), name: 'Jigyasa', role: 'Owner'),
        ],
        files: [],
        messages: [],
      ),
      Trip(
        id: _uuid.v4(),
        title: 'Manali Adventure',
        location: 'Manali, India',
        startDate: DateTime(2026, 2, 2),
        endDate: DateTime(2026, 2, 7),
        imagePath: 'assets/images/manali.jpg',
        itinerary: [],
        checklist: ['Warm layers', 'Cash'],
        packing: ['Thermals', 'Gloves', 'Boots'],
        travelers: [
          Traveler(id: _uuid.v4(), name: 'Jigyasa', role: 'Owner'),
        ],
        files: [],
        messages: [],
      ),
    ]);

    notifyListeners();
  }

  Trip? getTripById(String id) {
    try {
      return _trips.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  void addTrip({
    required String title,
    required String location,
    required DateTime startDate,
    required DateTime endDate,
    required String imagePath,
  }) {
    _trips.add(
      Trip(
        id: _uuid.v4(),
        title: title,
        location: location,
        startDate: startDate,
        endDate: endDate,
        imagePath: imagePath,
        itinerary: [],
        checklist: [],
        packing: [],
        travelers: [
          Traveler(id: _uuid.v4(), name: 'Jigyasa', role: 'Owner'),
        ],
        files: [],
        messages: [],
      ),
    );
    notifyListeners();
  }

  void addGuestTraveler(String name) {
    if (_trips.isEmpty) return;
    _trips.last.travelers.add(
      Traveler(
        id: _uuid.v4(),
        name: name,
        role: 'Guest',
      ),
    );
    notifyListeners();
  }

  void addTravelerToTrip({
    required String tripId,
    required Traveler traveler,
  }) {
    final trip = getTripById(tripId);
    if (trip == null) return;
    trip.travelers.add(traveler);
    notifyListeners();
  }

  void addFileToTrip({
    required String tripId,
    required String fileName,
    required String path,
  }) {
    final trip = getTripById(tripId);
    if (trip == null) return;

    trip.files.add(
      TripFile(
        id: _uuid.v4(),
        name: fileName,
        path: path,
        addedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void sendMessage({
    required String tripId,
    required String senderName,
    required String text,
  }) {
    final trip = getTripById(tripId);
    if (trip == null) return;

    trip.messages.add(
      ChatMessage(
        id: _uuid.v4(),
        senderName: senderName,
        text: text,
        sentAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
