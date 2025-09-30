// backend data models

// example event name:  Earthmovements
// date: "2020-01-01"
// description: "A significant earthquake was recorded."
class Event {
  final String name;
  final String date; // e.g., "2020-01-01"
  final String description;
  final List<Comment> comments;

  Event({
    required this.name,
    required this.date,
    required this.description,
    required this.comments,
  });
}

// example valcano
//name: "Mount St. Helens"
//lacation: "Washington, USA"
//recordedEvents: [event(name: "Eruption", date: "1980-05-18", description: "Major eruption causing significant damage.")],
//lastEruption: "2008"
class Volcano {
  final String name;
  final String location;
  final List<Event> recordedEvents;
  final String lastEruption; // e.g., "2020", "Unknown", etc.

  Volcano({
    required this.name,
    required this.location,
    required this.lastEruption,
    required this.recordedEvents,
  });
}

class User {
  final String username;
  final String email;
  final bool admin;

  User({required this.username, required this.email, required this.admin});
}

class Comment {
  final String createdBy; // username
  final String content;
  final String date; // e.g., "2020-01-01"

  Comment({required this.createdBy, required this.content, required this.date});
}
