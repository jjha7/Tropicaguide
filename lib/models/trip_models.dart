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

class Trip {
  final String id;
  final String title;
  final String location;
  final DateTime start;
  final DateTime end;
  final String coverAsset;

  final List<Traveler> members;
  final List<TripFile> files;
  final List<ChatMessage> chat;

  Trip({
    required this.id,
    required this.title,
    required this.location,
    required this.start,
    required this.end,
    required this.coverAsset,
    required this.members,
    required this.files,
    required this.chat,
  });
}
