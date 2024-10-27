import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safar/core/utils/app_constants.dart';
import 'package:safar/core/widgets/app_text.dart';
import 'package:safar/feature/home/model/homepage_model.dart';
import 'package:safar/feature/stories/model/stories_model.dart';
import 'package:safar/feature/stories/viewmodel/bloc.dart';
import 'package:sizer/sizer.dart';

import '../../viewmodel/events.dart';

void createStoryDialog(BuildContext context, HomePageModel trip) async {
  final colors = Theme.of(context).extension<AppColorsTheme>();
  final ImagePicker picker = ImagePicker();
  String imageName = '';
  StoryBloc storyBloc = StoryBloc(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: AppText.subtitleDefaultBold(
          AppString.createStory,
          size: 20.sp,
          context: context,
          color: Colors.black,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.defaultTextBold(AppString.storyTitle,
                size: 16.sp, context: context, color: Colors.black),
            Padding(
              padding: EdgeInsets.only(top: 1.h, bottom: 1.5.h),
              child: Container(
                height: 5.5.h,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: storyBloc.textEditingController,
                  decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ))),
                ),
              ),
            ),
            AppText.defaultTextBold(AppString.storythumbnail,
                size: 16.sp, context: context, color: Colors.black),
            SizedBox(height: 1.5.h),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  imageName == '' || imageName.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (image != null) {
                                  if (context.mounted) {
                                    setState(() {
                                      context.read<StoryBloc>().imagePath =
                                          image.path;
                                      imageName = image.name;
                                    });
                                  }
                                } else {
                                  log('No image selected from camera.');
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                height: 5.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        size: 2.h,
                                      ),
                                      AppText.subtitleDefault(
                                        'Camera',
                                        context: context,
                                        size: 14.sp,
                                        color: Colors.black,
                                      )
                                    ]),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (image != null) {
                                  if (context.mounted) {
                                    setState(() {
                                      context.read<StoryBloc>().imagePath =
                                          image.path;
                                      imageName = image.name;
                                    });
                                  }
                                } else {
                                  log('No image selected from gallery.');
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                height: 5.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.upload,
                                        size: 2.h,
                                      ),
                                      AppText.subtitleDefault(
                                        'Gallery',
                                        context: context,
                                        size: 14.sp,
                                        color: Colors.black,
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              context.read<StoryBloc>().imagePath = '';
                              imageName = '';
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      imageName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(Icons.cancel)
                                ],
                              )),
                        ),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: AppText.subtitleDefaultBold(AppString.cancel,
                size: 14.sp, context: context, color: colors!.snackBarFailure),
          ),
          TextButton(
            onPressed: () {
              context.read<StoryBloc>().add(CreateStoryEvent(
                  story: Stories(
                      tripId: trip.tripId,
                      storyId: trip.stories.length + 1,
                      storyName: storyBloc.textEditingController.text,
                      storyImage: context.read<StoryBloc>().imagePath,
                      days: [])));
              Navigator.pop(context);
            },
            child: AppText.subtitleDefaultBold(AppString.create,
                size: 14.sp, context: context, color: colors.primary),
          )
        ],
      );
    },
  );
}
