import '../../stories/model/stories_model.dart';

class HomePageModel {
  int tripId;
  String tripName;
  String tripImage;
  List<Stories> stories;

  HomePageModel({
    required this.tripId,
    required this.tripName,
    required this.tripImage,
    required this.stories,
  });

  // Method to convert from JSON
  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      tripId: json["tripId"],
      tripName: json["tripName"],
      tripImage: json["tripImage"],
      stories: (json["stories"] as List)
          .map((story) => Stories.fromJson(story as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "tripId": tripId,
      "tripName": tripName,
      "tripImage": tripImage,
      "stories": stories.map((story) => story.toJson()).toList(),
    };
  }
}
