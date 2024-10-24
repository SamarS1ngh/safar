import 'package:flutter/material.dart';
import 'package:safar/core/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/app_constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsTheme>();

    return Drawer(
      backgroundColor: colors!.secondary,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: colors.primary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade300,
                  size: 6.h,
                ),
              ),
              accountName: AppText.defaultTextBold(
                AppString.accountName,
                context: context,
                size: 16.sp,
              ),
              accountEmail: AppText.subtitleDefault(AppString.accountEmail,
                  size: 14.sp, context: context)),
          ListTile(
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {},
          ),
          const Expanded(child: SizedBox()),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              AppString.logout,
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
