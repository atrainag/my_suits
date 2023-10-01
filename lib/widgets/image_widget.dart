import "dart:io";
import "package:permission_handler/permission_handler.dart";
import "package:flutter/material.dart";
import "package:my_suits/utils/card_colors.dart";
import "package:my_suits/models/photo.dart";
import 'package:intl/intl.dart';
import "package:path_provider/path_provider.dart";

class ImageWidget extends StatelessWidget {
  final int index;
  final Photo photo;
  const ImageWidget({
    Key? key,
    required this.photo,
    required this.index,
  }) : super(key: key);
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }

  Future<Image>? _displayImage() async {
    // Check if storage permission is granted
    var status = await Permission.storage.request();

    if (status.isGranted) {
      // Permission granted, you can access and display the image
      // Add code to display the image here
      return Image.file(
        File(photo.imagePath!),
        width: 200,
        height: 200,
      );
    }
    return Image.network(
        'https://as1.ftcdn.net/v2/jpg/02/99/61/74/1000_F_299617487_fPJ8v9Onthhzwnp4ftILrtSGKs1JCrbh.jpg');
  }

  Future<String> _getImagePath() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final imagePath = appDocDir.path + photo.imagePath!;
    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    final color = cardColors[index % cardColors.length];
    //final minHeight = getMinHeight(index);
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder<Image?>(
              future:
                  _displayImage(), // Your future function that returns an Image or null
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return snapshot.data!; // Display the Image widget
                  } else {
                    return const Text('No image available.');
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                DateFormat('yyyy-MM-dd HH:mm:ss').format(photo.timestamp!),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
