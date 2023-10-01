import "dart:io";

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

  Future<String> _getImagePath() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final imagePath = appDocDir.path + photo.imagePath!;
    return imagePath;
  }

  @override
  Widget build(BuildContext context) {
    final color = cardColors[index % cardColors.length];
    final minHeight = getMinHeight(index);
    return Card(
        color: color,
        child: Container(
          constraints: BoxConstraints(
            minHeight: minHeight,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            FutureBuilder<String>(
              future: _getImagePath(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Image.file(
                    File(snapshot.data!),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(photo.timestamp!),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 5,
                  fontWeight: FontWeight.bold,
                ))
          ]),
        ));
  }
}
