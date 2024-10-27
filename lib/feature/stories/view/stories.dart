import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safar/Routes/app_router_config.dart';
import 'package:safar/core/widgets/app_text.dart';
import 'package:safar/feature/home/model/homepage_model.dart';
import 'package:safar/feature/stories/view/widgets/create_story_dialog.dart';
import 'package:safar/feature/stories/viewmodel/bloc.dart';
import 'package:safar/feature/stories/viewmodel/events.dart';

import '../../../core/utils/app_constants.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Stories extends StatelessWidget {
  final HomePageModel trip;
  const Stories({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    context.read<StoryBloc>().add(GetStoriesEvent(trip: trip));
    final colors = Theme.of(context).extension<AppColorsTheme>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => createStoryDialog(context, trip),
              icon: const Icon(Icons.add_box_rounded))
        ],
        centerTitle: true,
        title: AppText.defaultTextBold(trip.tripName, context: context),
      ),
      body: trip.stories.isEmpty
          ? Center(
              child: AppText.defaultTextBold(AppString.noStories,
                  color: colors!.primary, context: context))
          : ListView.builder(
              itemCount: trip.stories.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      context.go('/stories/day');
                    },
                    tileColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                    leading: Image.file(
                      File(trip.stories[index].storyImage),
                      fit: BoxFit.cover,
                    ),
                    title: AppText.defaultTextBold(
                        trip.stories[index].storyName,
                        color: Colors.black,
                        context: context),
                  ),
                ),
              ),
            ),
    );
  }
}
