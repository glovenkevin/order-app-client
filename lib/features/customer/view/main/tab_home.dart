import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:order_app_client/component/custom_app_bar_main.dart';
import 'package:order_app_client/features/customer/domain/entity/menu.dart';
import 'package:order_app_client/features/customer/resources/color/base_color.dart';
import 'package:order_app_client/features/customer/view/main/component/menu_bottom_modal.dart';
import 'package:order_app_client/features/customer/viewmodel/main/tab_home_vm.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  static const ValueKey homeAppBarKey = ValueKey('homeAppBarKey');
  late TabHomeViewModel vm;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => vm.retrieveMenues());
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<TabHomeViewModel>(context);
    final CarouselController carouselController = CarouselController();
    const double fontSizeJudul = 24;
    const double fontSizeJudulDeskripsi = 14;
    const double fontSizeDeskripsi = 12;

    return SafeArea(
        minimum: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Scaffold(
            appBar: CustomAppBarMain(
              key: homeAppBarKey,
              height: MediaQuery.of(context).size.height * 0.1,
              fullName: 'John Doe',
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  const Text('Start shop at our',
                      style: TextStyle(
                          fontSize: fontSizeJudul,
                          fontWeight: FontWeight.w800,
                          color: AppDefaultColor.defaultBrown)),
                  const Text('premium store',
                      style: TextStyle(
                          fontSize: fontSizeJudul,
                          fontWeight: FontWeight.bold,
                          color: AppDefaultColor.defaultBrown)),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.25,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            vm.setBannerIndex(index);
                          });
                        },
                      ),
                      items: vm.images.map((url) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: vm.images.asMap().entries.map((entry) {
                      return _bannerDots(context, vm.bannerIndex, entry);
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  if (vm.menus.isNotEmpty) ...[
                    const Text('Menu',
                        style: TextStyle(
                            fontSize: fontSizeJudul,
                            fontWeight: FontWeight.w800,
                            color: AppDefaultColor.defaultBrown)),
                    const Text("Checkout our new menu,",
                        style: TextStyle(
                            fontSize: fontSizeDeskripsi,
                            color: AppDefaultColor.defaultGrey)),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: [
                        ...vm.menus.map((menu) {
                          return Card(
                            elevation: 5,
                            child: InkWell(
                              splashColor: AppDefaultColor.defaultBlue,
                              onTap: () {
                                _showBottomModalMenu(context, menu);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          menu.imageUrl,
                                          width: 80,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Text(
                                                "Failed to load Image");
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(menu.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: fontSizeJudulDeskripsi,
                                            color: Colors.black87)),
                                    Text(menu.description,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: fontSizeDeskripsi,
                                            color:
                                                AppDefaultColor.defaultGrey)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 15)
                  ]
                ],
              ),
            )));
  }

  Container _bannerDots(
      BuildContext context, int activeBanner, MapEntry<int, String> entry) {
    return Container(
      width: 12.0,
      height: 12.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)
              .withOpacity(activeBanner == entry.key ? 0.9 : 0.4)),
    );
  }

  void _showBottomModalMenu(BuildContext context, Menu menu) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DetailMenuBottomModal(
            menu: menu,
            vm: vm,
          );
        });
  }
}
