import 'package:equatable/equatable.dart';

class BlindDate extends Equatable {
  final int bookId;
  final String image;
  final String description;

  BlindDate({this.bookId, this.image, this.description});

  @override
  List<Object> get props => [bookId, description];

}