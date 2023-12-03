import 'package:flutter/material.dart';
import 'package:smart_mart/views/screens/widget/banner_widget.dart';
import 'package:smart_mart/views/screens/widget/location_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationWidget(),
        SizedBox(
          height: 20,
        ),
        BannerWidget(),
      ],
    );
  }
}
