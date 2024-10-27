import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safar/feature/home/view_model/bloc.dart';
import 'package:safar/feature/home/view_model/events.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/app_text.dart';
import '../../model/homepage_model.dart';

void createTripDialog(BuildContext context, HomePageBloc homePageBloc) {
  final colors = Theme.of(context).extension<AppColorsTheme>();
  final ImagePicker picker = ImagePicker();
  String imageName = '';
  context.read<HomePageBloc>()
    ..textEditingController.clear()
    ..imagePath = '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.defaultTextBold(AppString.tripTitle,
                color: Colors.black, size: 18.sp, context: context),
            Padding(
              padding: EdgeInsets.only(top: 1.h, bottom: 1.5.h),
              child: Container(
                height: 5.5.h,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: homePageBloc.textEditingController,
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
            AppText.defaultTextBold(
              AppString.tripImage,
              context: context,
              size: 18.sp,
              color: Colors.black,
            ),
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
                                      context.read<HomePageBloc>().imagePath =
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
                                      context.read<HomePageBloc>().imagePath =
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
                              context.read<HomePageBloc>().imagePath = '';
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
        title: AppText.defaultTextBold(
          AppString.createTrip,
          context: context,
          color: Colors.black,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: AppText.defaultTextBold(AppString.cancel,
                  size: 14.sp,
                  color: colors!.snackBarFailure,
                  context: context)),
          TextButton(
              onPressed: () {
                if (context.read<HomePageBloc>().imagePath.isNotEmpty &&
                    homePageBloc.textEditingController.text.isNotEmpty) {
                  homePageBloc.add(CreateTripEvent(HomePageModel(
                      tripId: homePageBloc.trips.length + 1,
                      tripImage: context.read<HomePageBloc>().imagePath,
                      tripName: homePageBloc.textEditingController.text,
                      stories: [])));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.white,
                    content: Text(
                      "Please fill the form correctly",
                      style: TextStyle(color: colors.snackBarFailure),
                    ),
                  ));
                }
              },
              child: AppText.defaultTextBold(AppString.create,
                  size: 14.sp, color: colors.primary, context: context)),
        ],
      );
    },
  );
}
