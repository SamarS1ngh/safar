import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safar/feature/home/model/homepage_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/app_text.dart';
import '../../view_model/bloc.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key, required this.trips});
  final List<HomePageModel> trips;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: GridView.builder(
        itemCount: trips.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            mainAxisSpacing: 2.h,
            crossAxisSpacing: 3.w,
            crossAxisCount: 2),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.go('/stories', extra: {"trip": trips[index]});
          },
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.read<HomePageBloc>().getRandomColor(),
                      context.read<HomePageBloc>().getRandomColor(),
                    ]),
                color: const Color.fromARGB(101, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(
                    File(trips[index].tripImage),
                    height: 20.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 1.h),
                  Flexible(
                    child: AppText.defaultTextBold(
                        textOverflow: TextOverflow.ellipsis,
                        size: 18.sp,
                        trips[index].tripName,
                        color: Colors.black,
                        context: context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
