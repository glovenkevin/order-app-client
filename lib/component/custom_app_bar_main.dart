import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';

class CustomAppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarMain({
    Key? key,
    required this.height,
    required this.fullName,
  }) : super(key: key);

  final double height;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  EasyLoading.showInfo("Comming soon");
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi $fullName,',
                    style: const TextStyle(
                        fontSize: 12, color: AppDefaultColor.defaultGrey)),
                const Text('Wellcome back',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppDefaultColor.defaultGrey)),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, "/settings");
                }),
          ],
        )
      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
