import "package:flutter/material.dart";
import 'package:my_suits/models/photo.dart';
import 'package:my_suits/widgets/image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> photos = [
    Photo(
        id: 1,
        imagePath: "/Internal storage/DCIM/Camera/20230928_141152.jpg",
        timestamp: DateTime.now()),
    Photo(
        id: 2,
        imagePath:
            "/Internal storage/DCIM/Screenshots/Screenshot_20230912-021424_Samsung Notes.jpg",
        timestamp: DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Pictures",
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return ImageWidget(photo: photos[index], index: index);
          },
          itemCount: photos.length,
        ),
      ),
    );
  }
}
