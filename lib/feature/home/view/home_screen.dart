import 'package:flutter/material.dart';
import 'package:safar/core/utils/app_constants.dart';
import 'package:safar/core/widgets/app_text.dart';
import 'package:safar/feature/home/view/widgets/drawer.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu)),
        centerTitle: true,
        title: AppText.defaultTextBold(AppString.appName, context: context),
      ),
    );
  }
}
