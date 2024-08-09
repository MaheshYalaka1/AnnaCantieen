import 'package:anna_cantean/home_page/About_page.dart';
import 'package:anna_cantean/home_page/donation_page.dart';
import 'package:anna_cantean/home_page/foodList_page.dart';

import 'package:anna_cantean/home_page/survice.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? username;
  String? gmail;
  Map<String, dynamic> Updatedata = {};
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xfffff8f8),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Anna Canteen",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              accountEmail: Text(''),
              decoration: BoxDecoration(color: Colors.orange),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset('assets/images/party.png')),
            ),
            ListTile(
              leading: Icon(
                Icons.food_bank_sharp,
                color: Colors.orange.shade800,
              ),
              title: const Text('Food menu'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FoodList()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.orange.shade800,
              ),
              title: const Text('Feedback reviews'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RatingPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.currency_rupee,
                color: Colors.orange.shade800,
              ),
              title: const Text('Donation'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DonetionPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.file_open_rounded,
                color: Colors.orange.shade800,
              ),
              title: const Text('About'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.orange.shade800,
              ),
              title: const Text('Near Location'),
              onTap: () {},
            ),
          ],
        ));
  }
}
