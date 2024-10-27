import 'package:safar/feature/home/model/homepage_model.dart';
import 'package:safar/feature/stories/model/stories_model.dart';

abstract class StoryEvents {}

class CreateStoryEvent extends StoryEvents {
  Stories story;
  CreateStoryEvent({required this.story});
}

class GetStoriesEvent extends StoryEvents {
  HomePageModel trip;
  GetStoriesEvent({required this.trip});
}

class DeleteStoryEvent extends StoryEvents {}

class UpdateStoryEvent extends StoryEvents {}
