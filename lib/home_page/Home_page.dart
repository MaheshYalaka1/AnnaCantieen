import 'package:anna_cantean/home_page/banner_page.dart';
import 'package:anna_cantean/home_page/donation_page.dart';
import 'package:anna_cantean/home_page/dropdown.dart';
import 'package:anna_cantean/home_page/foodList_page.dart'; // Ensure correct import path
import 'package:anna_cantean/home_page/survice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io' as io;

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
          'Home page',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF4F3F3),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xffBFBFBF)),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              decoration: const BoxDecoration(color: Color(0xffE20736)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
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
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: 190,
                          child: Text(
                            locationController.text,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                            maxLines: 2,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFEBE6),
                            foregroundColor: const Color(0xfff1ba63),
                            shadowColor: const Color(0xff930428),
                            elevation: 8,
                          ),
                          child: const Text(
                            "Change location",
                            style: TextStyle(color: Color(0xffE20736)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 10),
            const banners(), // Ensure `banners` is a valid widget
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
                  ourServices('assets/images/food.png', "Food Menu", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FoodList(), // Correct `context`
                      ),
                    );
                  }),
                  ourServices("assets/images/review.png", "Feedback Reviews",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RatingPage(), // Correct `context`
                      ),
                    );
                  }),
                  ourServices("assets/images/donate.png", "Donation", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DonetionPage(), // Correct `context`
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

  // ignore: non_constant_identifier_names
  Widget ourServices(String image, String title, VoidCallback onPressed) {
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
          onPressed: onPressed, // Call the callback directly
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
                        fit: BoxFit
                            .cover, // Ensures the image covers the CircleAvatar without distortion
                        height: 60, // Adjust height if needed
                        width: 60, // Adjust width if needed
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
      // Check and request location permissions
      await _checkLocationPermission();

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      await _getAddress(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
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
            '${addressPlacemark.subLocality}, ${addressPlacemark.locality},';
        // '${addressPlacemark.street},${addressPlacemark.subLocality}, ${addressPlacemark.locality},${addressPlacemark.administrativeArea},${addressPlacemark.postalCode}, ${addressPlacemark.country}';
        print("maheshj: $formattedAddress");

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
    // Only check and request permission if running on Android
    if (io.Platform.isAndroid) {
      var status = await Permission.location.status;
      if (status != PermissionStatus.granted) {
        // Request permission if it is not granted
        await Permission.location.request();
      }
    }
    // iOS permissions are handled through Info.plist
  }
}
