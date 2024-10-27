import 'package:safar/feature/home/model/homepage_model.dart';

abstract class HomePageStates {}

class HomePageInitialState extends HomePageStates {
  List<HomePageModel>? trips;
  HomePageInitialState({this.trips});
}

class HomePageLoadingState extends HomePageStates {}

class HomePageErrorState extends HomePageStates {
  final String error;

  HomePageErrorState({required this.error});
}

class HomePageLoadedState extends HomePageStates {
  List<HomePageModel>? trips;
  HomePageLoadedState({this.trips});
}
