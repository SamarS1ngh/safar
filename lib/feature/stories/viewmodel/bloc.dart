import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safar/feature/home/model/homepage_model.dart';
import 'package:safar/feature/home/view_model/bloc.dart';
import 'package:safar/feature/home/view_model/events.dart';
import 'package:safar/feature/stories/model/stories_model.dart';
import 'package:safar/feature/stories/viewmodel/events.dart';
import 'states.dart';

class StoryBloc extends Bloc<StoryEvents, StoryStates> {
  late TextEditingController textEditingController;
  late HomePageBloc homePageBloc;
  String imagePath = '';
  List<Stories> stories = [];
  StoryBloc(BuildContext context) : super(StoryInitialState()) {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    textEditingController = TextEditingController();
    on<GetStoriesEvent>((event, emit) {
      stories = event.trip.stories;
      emit(StoryLoadedState(stories));
    });
    on<CreateStoryEvent>((event, emit) async {
      emit(StoryLoadingState());
      stories = [event.story, ...stories];
      emit(StoryLoadedState(stories));

      List<HomePageModel> trips = await homePageBloc.loadTrips();
      HomePageModel trip = trips.firstWhere(
        (element) => element.tripId == event.story.tripId,
      );

      trips.removeWhere(
        (element) => element.tripId == trip.tripId,
      );
      trip.stories = [event.story, ...trip.stories];
      trips = [trip, ...trips];
      log(trips[0].tripName.toString());
      if (context.mounted) {
        homePageBloc.add(UpdateTripEvent(trips));
      }
    });
    // on<UpdateStoryEvent>((event, emit) => emit(StoryLoadedState()));
    // on<DeleteStoryEvent>((event, emit) => emit(StoryLoadedState()));
  }
}
