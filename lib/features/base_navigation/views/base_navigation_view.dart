import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BaseNavigationView extends StatefulWidget {
  const BaseNavigationView({super.key});

  @override
  State<BaseNavigationView> createState() => _BaseNavigationViewState();
}

class _BaseNavigationViewState extends State<BaseNavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("data"),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          iconSize: 36,
          useLegacyColorScheme: false,
          backgroundColor: Colors.white,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle:
              const TextStyle(fontSize: 11, fontFamily: "Poppins"),
          onTap: (index) {
            if (index == 0) {}
          },
          items: const [
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(EvaIcons.homeOutline),
                    Gap(3),
                  ],
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(EvaIcons.gridOutline),
                    Gap(3),
                  ],
                ),
                label: "Category"),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.shopping_basket_outlined),
                    Gap(3),
                  ],
                ),
                label: "Cart"),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(EvaIcons.giftOutline),
                    Gap(3),
                  ],
                ),
                label: "Wish"),
          ],
        ),
      ),
    );
  }
}
