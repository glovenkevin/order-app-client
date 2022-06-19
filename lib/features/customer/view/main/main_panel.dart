import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/view/main/tab_home.dart';

class MainPanelPage extends StatefulWidget {
  const MainPanelPage({Key? key}) : super(key: key);

  @override
  MainPanelPageState createState() => MainPanelPageState();
}

class MainPanelPageState extends State<MainPanelPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  static const ValueKey homeKey = ValueKey('home');

  static const List<Widget> _tabs = [
    HomeTab(key: homeKey),
    Tab(
      child: Text("cart"),
    ),
    Tab(
      child: Text("history"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: TabBarView(controller: _tabController, children: _tabs),
        bottomNavigationBar: FloatingNavbar(
          onTap: (int val) => {
            setState(() {
              _tabIndex = val;
            }),
            _tabController.index = val
          },
          currentIndex: _tabIndex,
          backgroundColor: AppDefaultColor.defaultBrown,
          selectedItemColor: AppDefaultColor.defaultYellow,
          selectedBackgroundColor: Colors.transparent,
          items: [
            FloatingNavbarItem(
              icon: Icons.home,
              title: "Home",
            ),
            FloatingNavbarItem(
              icon: Icons.shopping_bag,
              title: "Cart",
            ),
            FloatingNavbarItem(
              icon: Icons.history,
              title: "History",
            ),
          ],
        ));
  }
}
