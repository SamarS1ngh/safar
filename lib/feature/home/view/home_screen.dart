import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safar/core/utils/app_constants.dart';
import 'package:safar/core/widgets/app_text.dart';
import 'package:safar/data/local/local_storage_service.dart';
import 'package:safar/feature/home/view/widgets/create_trip_dialog.dart';
import 'package:safar/feature/home/view/widgets/drawer.dart';
import 'package:safar/feature/home/view/widgets/story_card.dart';
import 'package:safar/feature/home/view_model/bloc.dart';
import 'package:safar/feature/home/view_model/events.dart';
import 'package:safar/feature/home/view_model/states.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomePageBloc _homePageBloc;
  @override
  void initState() {
    _homePageBloc = HomePageBloc();
    _homePageBloc.add(GetHomePageDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsTheme>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: colors!.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => createTripDialog(context, _homePageBloc),
      ),
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu)),
        centerTitle: true,
        title: AppText.defaultTextBold(AppString.appName, context: context),
      ),
      body: BlocConsumer<HomePageBloc, HomePageStates>(
          listener: (context, state) {
            log(state.toString());
          },
          builder: (context, state) {
            if (state is HomePageInitialState) {
              return Center(
                  child: AppText.defaultTextBold(
                context: context,
                AppString.createStory,
                color: colors.primary,
              ));
            } else if (state is HomePageLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              );
            } else if (state is HomePageLoadedState) {
              return state.trips!.isNotEmpty
                  ? StoryCard(trips: state.trips!)
                  : Center(
                      child: AppText.defaultTextBold(
                      context: context,
                      AppString.createStory,
                      color: colors.primary,
                    ));
            } else if (state is HomePageErrorState) {
              return Center(
                  child: AppText.defaultTextBold(
                context: context,
                state.error,
                color: colors.snackBarFailure,
              ));
            } else {
              return const Center(
                child: Text('data'),
              );
            }
          },
          bloc: _homePageBloc),
    );
  }
}
