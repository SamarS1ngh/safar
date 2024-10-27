import '../model/stories_model.dart';

abstract class StoryStates {}

class StoryInitialState extends StoryStates {}

class StoryLoadedState extends StoryStates {
  final List<Stories> stories;
  StoryLoadedState(this.stories);
}

class StoryLoadingState extends StoryStates {}

class StoryErrorState extends StoryStates {}
