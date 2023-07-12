import 'package:favourite_place/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});

  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(children: [
        Image.file(
          place.image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )
      ]),
    );
  }
}
