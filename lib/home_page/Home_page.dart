import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:anna_cantean/home_page/banner_page.dart';
import 'package:anna_cantean/home_page/donation_page.dart';
import 'package:anna_cantean/home_page/dropdown.dart';
import 'package:anna_cantean/home_page/foodList_page.dart';
import 'package:anna_cantean/home_page/survice.dart'; // Ensure correct import path

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController locationController = TextEditingController();
  String address = 'Address: ';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFEBD01),
        title: const Text(
          'Home Page',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          Container(
            width: 70,
            height: 100,
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/party.png'),
              ),
            ),
          ),
        ],
      ),
      drawer: const Dropdown(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: const BoxDecoration(color: Color(0xffE20736)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      icon: const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xffFFD300),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 280,
                      child: Text(
                        locationController.text,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const banner(), // Ensure `BannerPage` is a valid widget
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Support & Feedback',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.more_horiz,
                    size: 30,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _ourServices('assets/images/food.png', "Food Menu", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FoodList(), // Ensure `FoodList` is a valid widget
                      ),
                    );
                  }),
                  _ourServices("assets/images/review.png", "Feedback Reviews",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RatingPage(), // Ensure `RatingPage` is a valid widget
                      ),
                    );
                  }),
                  _ourServices("assets/images/donate.png", "Donation", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DonetionPage(), // Ensure `DonationPage` is a valid widget
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ourServices(String image, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffFFEBE6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: CupertinoButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: ClipOval(
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.more_vert,
                size: 40,
                color: Color(0xff853232),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      await _checkLocationPermission();

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      await _getAddress(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        locationController.text = 'Error getting location';
        address = 'Error getting location';
      });
    }
  }

  Future<void> _getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark addressPlacemark = placemarks[0];
        String formattedAddress =
            '${addressPlacemark.subLocality}, ${addressPlacemark.locality}';
        print("Formatted Address: $formattedAddress");

        setState(() {
          locationController.text = formattedAddress;
          address = formattedAddress;
        });
      } else {
        print('No address found for the provided coordinates.');
        setState(() {
          locationController.text = 'No address found';
          address = 'No address found';
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        locationController.text = 'Error getting address';
        address = 'Error getting address';
      });
    }
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
