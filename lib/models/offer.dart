import 'package:flutter/foundation.dart';

class Offer {
  final String description;

  final String destination;

  final String image;

  final int destinationId;

  final String title;

  Offer( {
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.destination,
    @required this.destinationId,
  });
}