import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:smart_mart/views/screens/main_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late GoogleMapController mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  late Position currentPosition;
  getUserCurrentLocation() async {
    await Geolocator.checkPermission();

    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        forceAndroidLocationManager: true);

    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 16);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.none,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              mapController = controller;

              getUserCurrentLocation();
            }),
        Positioned(
          bottom: 0,
          child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 70,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.offAll(MainScreen());
                        },
                        icon: Icon(CupertinoIcons.shopping_cart),
                        label: Text(
                          'SHOP NOW',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 3),
                        ),
                      )),
                ],
              )),
        )
      ]),
    );
  }
}
