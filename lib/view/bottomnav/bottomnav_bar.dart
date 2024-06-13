import 'package:d_art/view/serviceprovider/addscreen.dart';
import 'package:d_art/view/serviceprovider/profilescreen.dart';
import 'package:d_art/view/serviceprovider/searchscreen.dart';
import 'package:d_art/view/serviceprovider/serviceHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'package:d_art/controller/controller/bottomnavbarcontroller.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavBarController controller = Get.put(BottomNavBarController());

  BottomNavBar({super.key});

  final List<Widget> _screens = [
    ServiceHome(),
    const SearchScreen(),
    const AddWorkScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() =>
          _screens[SelectedTab.values.indexOf(controller.selectedTab.value)]),
      bottomNavigationBar: Obx(() => SizedBox(
            height: 125,
            child: DotNavigationBar(
              backgroundColor: Colors.grey,
              margin: const EdgeInsets.only(left: 10, right: 10),
              currentIndex:
                  SelectedTab.values.indexOf(controller.selectedTab.value),
              dotIndicatorColor: Color.fromARGB(255, 160, 241, 8),
              unselectedItemColor: Colors.black,
              splashBorderRadius: 50,
              onTap: controller.changeTab,
              items: [
                DotNavigationBarItem(
                    icon: const Icon(Icons.home), selectedColor: Colors.amber),
                DotNavigationBarItem(
                    icon: const Icon(Icons.search),
                    selectedColor: Colors.amber),
                DotNavigationBarItem(
                    icon: const Icon(Icons.add), selectedColor: Colors.amber),
                DotNavigationBarItem(
                    icon: const Icon(Icons.person), selectedColor: Colors.amber)
              ],
            ),
          )),
    );
  }
}
