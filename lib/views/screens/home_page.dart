import 'package:flutter/material.dart';
import 'package:flutter_group_1/core/settings_util.dart';
import 'package:flutter_group_1/views/screens/nav_bar_pages/categories_screen.dart';
import 'package:flutter_group_1/views/screens/nav_bar_pages/main_screen.dart';
import 'package:flutter_group_1/views/screens/nav_bar_pages/settings_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int pageIndex = 0;
  late String phoneNumber = "";
  final List<Widget> pages = [
    const MainScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    getPhoneNumber();
  }

  Future<void> getPhoneNumber() async {
    phoneNumber = await SettingsUtil.getCachedUserPhone();
    setState(() {});
  }

  Widget buildDrawerHeader() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 150,
      color: Colors.blue,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(
                  Icons.person,
                ),
              ),
              Text("User Name"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Phone: $phoneNumber")],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            buildDrawerHeader(),
            buildDrawerListTile(
              icon: Icons.person,
              title: "Profile",
              onTap: () async {},
            ),
            buildDrawerListTile(
              icon: Icons.add_shopping_cart,
              title: "Add product",
              onTap: () async {},
            ),
            buildDrawerListTile(
              icon: Icons.shopping_bag,
              title: "Cart",
              onTap: () async {},
            ),
            buildDrawerListTile(
              icon: Icons.settings,
              title: "Settings",
              onTap: () async {},
            ),
            const Divider(),
            buildDrawerListTile(
              icon: Icons.exit_to_app,
              title: "Sign out",
              onTap: () async {
                SettingsUtil.signOutFlow(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onNavBarTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  ListTile buildDrawerListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void onNavBarTapped(int index) {
    pageIndex = index;
    setState(() {});
  }
}
