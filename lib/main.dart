import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safar/Routes/app_router_config.dart';
import 'package:safar/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safar/feature/home/view_model/bloc.dart';
import 'package:sizer/sizer.dart';

import 'data/local/local_storage_service.dart';
import 'feature/stories/viewmodel/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await LocalStorageService.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<HomePageBloc>(create: (context) => HomePageBloc()),
    BlocProvider<StoryBloc>(create: (context) => StoryBloc(context)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LocalStorageService.clearAll();
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: Theme.of(context).copyWith(
            scaffoldBackgroundColor: AppColorsTheme.light().secondary,
            appBarTheme: AppBarTheme(
                actionsIconTheme: const IconThemeData(color: Colors.white),
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: AppColorsTheme.light().primary),
            extensions: [
              AppColorsTheme.light(),
              AppTypography.main(),
              AppDimensionsTheme.main(View.of(context))
            ]),
      );
    });
  }
}
