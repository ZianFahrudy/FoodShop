import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMenu {
  final String? title;
  final IconData? icon;

  ListMenu({this.title, this.icon});
}

List<ListMenu> menus = [
  ListMenu(
    title: "Home",
    icon: Icons.home,
  ),
  ListMenu(
    title: "Order",
    icon: Icons.shop,
  ),
  ListMenu(
    title: "Profile",
    icon: Icons.person,
  ),
];

class BottomNavbarWidget extends StatefulWidget {
  BottomNavbarWidget({Key? key, required this.selectedIndex, this.onTapItem})
      : super(key: key);

  final int selectedIndex;
  final Function? onTapItem;

  @override
  _BottomNavbarWidgetState createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: menus
          .asMap()
          .map((i, value) {
            return MapEntry(
                i,
                BottomNavigationBarItem(
                  label: value.title!,
                  icon: Icon(value.icon!,
                      color: Get.isDarkMode
                          ? (widget.selectedIndex == i
                              ? Colors.white
                              : Colors.grey)
                          : (widget.selectedIndex == i
                              ? Theme.of(context).primaryColor
                              : Colors.grey)),
                ));
          })
          .values
          .toList(),
      onTap: (i) => widget.onTapItem!(i),
      selectedItemColor:
          Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
      currentIndex: widget.selectedIndex,
      selectedLabelStyle: Theme.of(context).textTheme.bodyText2,
      unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
    );
  }
}
