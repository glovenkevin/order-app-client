import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/viewmodel/setting/setting_vm.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingViewModel vm = Provider.of<SettingViewModel>(context);

    List<Map<String, dynamic>> menuSettings = [
      {
        'name': 'Delete Account',
        'icon': Icons.no_accounts,
        'onTap': () {
          EasyLoading.showInfo("Coming Soon!");
        }
      },
      {
        'name': 'Log Out',
        'icon': Icons.logout,
        'onTap': () {
          EasyLoading.showSuccess("Success Log Out");
          vm.doLogOut(context);
        }
      }
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppDefaultColor.defaultGrey),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "John Doe",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 5),
              children: [
                ...menuSettings.map((elem) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: elem['onTap'],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: Row(
                            children: [
                              Icon(elem['icon']),
                              const SizedBox(width: 10),
                              Text(
                                elem['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
