import 'package:safar/feature/home/model/homepage_model.dart';

abstract class HomePageEvents {}

class GetHomePageDataEvent extends HomePageEvents {}

class CreateTripEvent extends HomePageEvents {
  HomePageModel trip;

  CreateTripEvent(this.trip);
}

class UpdateTripEvent extends HomePageEvents {
  List<HomePageModel> trips;

  UpdateTripEvent(this.trips);
}

class DeleteTripEvent extends HomePageEvents {}
