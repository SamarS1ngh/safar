import '../../days/model/days_model.dart';

class Stories {
  int tripId;
  int storyId;
  String storyName;
  String storyImage;
  List<Days> days;

  Stories({
    required this.tripId,
    required this.storyId,
    required this.storyName,
    required this.storyImage,
    required this.days,
  });

  // Convert a Stories object into a Map
  Map<String, dynamic> toJson() {
    return {
      "tripId": tripId,
      "storyId": storyId,
      "storyName": storyName,
      "storyImage": storyImage,
      "days": days.map((day) => day.toJson()).toList(),
    };
  }

  // Convert a Map into a Stories object
  factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
      tripId: json["tripId"],
      storyId: json["storyId"],
      storyName: json["storyName"],
      storyImage: json["storyImage"],
      days: (json["days"] as List)
          .map((day) => Days.fromJson(day as Map<String, dynamic>))
          .toList(),
    );
  }
}
