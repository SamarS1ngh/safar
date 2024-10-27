import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safar/data/local/local_storage.dart';

import 'package:flutter/material.dart';
import 'package:safar/feature/home/model/homepage_model.dart';
import 'package:safar/feature/home/view_model/events.dart';
import 'package:safar/feature/home/view_model/states.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageStates> {
  TextEditingController textEditingController = TextEditingController();
  String imagePath = '';
  List<HomePageModel> trips = [];

  Color getRandomColor() {
    math.Random random = math.Random();

    // Generate light RGB values, ensuring they are above a certain threshold (e.g., 128).
    int red = random.nextInt(128) + 128; // Random between 128 and 255
    int green = random.nextInt(128) + 128; // Random between 128 and 255
    int blue = random.nextInt(128) + 128; // Random between 128 and 255

    return Color.fromARGB(255, red, green, blue);
  }

  Future<List<HomePageModel>> loadTrips() async {
    try {
      List<String>? res =
          await LocalStorageService.getStringList(LocalStorageKeys.trips);
      if (res != null) {
        trips = res.map((e) => HomePageModel.fromJson(jsonDecode(e))).toList();
      } else {
        log('No trips found in local storage');
      }
      return trips;
    } catch (e) {
      log('Error loading trips: $e');
      return [];
    }
  }

  Future<List<HomePageModel>> saveTrips(HomePageModel trip) async {
    try {
      trips = await loadTrips();
      trips = [trip, ...trips];
      await LocalStorageService.setStringList(LocalStorageKeys.trips,
          trips.map((e) => jsonEncode(e.toJson())).toList());
      log('Trips saved: $trips');
      return trips;
    } catch (e) {
      log('Error saving trips: $e');
      return [];
    }
  }

  HomePageBloc() : super(HomePageInitialState(trips: [])) {
    on<GetHomePageDataEvent>((event, emit) async {
      emit(HomePageLoadingState());
      try {
        trips = await loadTrips();
        emit(HomePageLoadedState(trips: trips));
      } catch (e) {
        emit(HomePageErrorState(error: e.toString()));
      }
    });

    on<CreateTripEvent>(
      (event, emit) async {
        textEditingController = TextEditingController();
        emit(HomePageLoadingState());
        try {
          trips = await saveTrips(event.trip);
          emit(HomePageLoadedState(trips: trips));
        } catch (e) {
          emit(HomePageErrorState(error: e.toString()));
        }
      },
    );

    on<UpdateTripEvent>(
      (event, emit) async {
        emit(HomePageLoadingState());
        try {
          trips = event.trips;
          await LocalStorageService.setStringList(LocalStorageKeys.trips,
              trips.map((e) => jsonEncode(e.toJson())).toList());
          emit(HomePageLoadedState(trips: trips));
        } catch (e) {
          emit(HomePageErrorState(error: e.toString()));
        }
      },
    );
    on<DeleteTripEvent>(
      (event, emit) {
        log('DeleteTripEvent triggered');
        emit(HomePageLoadedState(trips: []));
      },
    );
  }
}
